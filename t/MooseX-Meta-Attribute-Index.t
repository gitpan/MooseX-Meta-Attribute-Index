
use Test::More tests => 9;        
BEGIN { diag 'MooseX::Meta::Attribute::Index'; }


##########
package App;
    use Test::More;

    BEGIN {
        use_ok( 'Moose' );
        use_ok( 'MooseX::Meta::Attribute::Index' );
    }

    has attr_1 => (
                     traits  => [ qw/Index/ ],
                     is      => 'rw'  ,
                     isa     => 'Str' ,
                     index=> 1 ,
    );

    has attr_2 => ( 
                     traits  => [ qw/Index/ ],
                     is      => 'rw'  ,
                     isa     => 'Int' ,
                     index=> 3
    );   



##########
package main;


    my $app = App->new( attr_1 => "foo", attr_2 => 42 );    

    isa_ok( $app, "App" );
    ok( $app->attr_1 eq "foo",  "Attribute 1" );
    ok( $app->attr_2 == 42, "Attribute 2" );


    ok( $app->meta->get_attribute_index( "attr_1" ) == 1, "Index 1 verified" ) ;
    ok( $app->meta->get_attribute_index( "attr_2" ) == 3, "Index 2 verified" ) ;

    ok( $app->meta->get_attribute_index( "attr_1" ) == 1, "Index 1 verified" ) ;
    ok( $app->meta->get_attribute_index( "attr_2" ) == 3, "Index 2 verified" ) ;


