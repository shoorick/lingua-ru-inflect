#!perl -T

use utf8;
use Test::More 'no_plan';

use Lingua::RU::Inflect qw/so ob/;

ok( ob('ели')   eq 'о',  'ob: iotified vowel' );
ok( so('осой')  eq 'с',  'so: vowel' );
