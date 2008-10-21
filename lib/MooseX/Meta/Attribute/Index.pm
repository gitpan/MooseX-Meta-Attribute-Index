package MooseX::Meta::Attribute::Index;

    our $VERSION = 0.02;
    our $AUTHORITY = 'cpan:CTBROWN';

    use Moose::Role;

    has index => ( 
        is      => 'rw' ,
        isa     => 'Int' ,
        predicate   => 'has_index' ,
        trigger     => sub { 
                my ( $self, $value, $meta ) = @_ ;
                if ( $value < 0 ) {
                    confess( "A negative value cannot be used as an " .
                             "index for an attribute.\n" );
                }
            } , 
    );



package Moose::Meta::Attribute::Custom::Trait::Index;
    sub register_implementation { 
        'MooseX::Meta::Attribute::Index' 
    };
    


package Moose::Meta::Class;

    sub get_attribute_index { 

        my $self = shift;
        my $name = shift;

        $self->get_attribute( $name )->index 
            or confess( "There is no attribute. $name" );
    }

package Moose::Class;

       sub get_attribute_index { 

            my $self = shift;
            my $name = shift;

            $self->meta->get_attribute( $name )->index 
                or confess( "There is no attribute. $name" );
        }      


1;


__END__

=pod 

=head1 NAME

MooseX::Meta::Attribute::Index - Provides index meta attribute trait


=head1 SYNOPSIS

    package App;
        use Moose;
            with 'MooseX::Meta::Attribute::Index';

        has attr_1 => ( 
            traits  => [ qw/Index/ ] ,
            is      => 'rw'     , 
            isa     => 'Str'    ,
            index   => 0
        );

        has attr_2 => (
            traits  => [ qw/Index/ ] ,
            is      => 'rw'     ,
            isa     => 'Int'    ,
            index   => 1
        ) ;


    package main;
        my $app = App->new( attr_1 => 'foo', attr_2 => 42 );
        
        $app->meta->get_attribute_index( "attr_1" );  # 0
        $app->meta->get_attribute_index( "attr_2" );  # 1


=head1 DESCRIPTION

Implements a meta-attribute, B<index>, using traits.   The index meta 
attribute is used for providing ordering of attributes.  This is useful
in situations where the order of attributes matters.  For example, 
see L<ODG::Record> where maintaining of the order of attributes allows 
for a Moose-based record iterator.

The indexes must be defined and provided manually.  The indexs are 
checked to ensure that negative indices are not used.

In addition to the meta-attribute, a Moose::Meta::Class method, 
C<get_attribute_index> is provided to retrieve the indices of an attribute.


=head1 METHODS

Moose::Meta::Class::get_attribute_index( $attr_name )

Returns the index for the named attribute.   


=head1 SEE ALSO

L<ODG::Record>, L<Moose>

=head1 AUTHOR

Christopher Brown, L<cbrown -at- opendatagroup.com>

L<http://www.opendatagroup,com>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2008 by Open Data

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.10.0 or,
at your option, any later version of Perl 5 you may have available.


=cut



