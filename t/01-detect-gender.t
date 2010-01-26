#-!perl -T

use utf8;
use Test::More 'no_plan';

BEGIN {
    use_ok('Lingua::RU::Inflect');
}

my $M = $Lingua::RU::Inflect::MASCULINE;
my $F = $Lingua::RU::Inflect::FEMININE;
my $d = \&Lingua::RU::Inflect::detect_gender;

# Masculine names
ok( $M == &$d( 'Иванов', 'Сергей', 'Михайлович' ),
    'usual russian masculine name: Sergey Mikhailovich Ivanov' );
ok( $M == &$d( 'Ильин', 'Роман' ),
    'usual russian masculine name without patronym: Roman Ilyin' );
ok( $M == &$d( undef, undef, 'Михалыч' ),
    'vulgar form of russian patronym: Mikhalych' );
ok( $M == &$d( 'Пушкин', undef, 'Сергеич' ),
    'lastname with vulgar form of patronym: Pushkin Sergeich' );
ok( $M == &$d( 'Репка', 'Илья' ),
    'russian masculine name ends to vowels without patronym: Ilya Repka' );
ok( $M == &$d( 'Ушко', 'Микола' ),
    'ukrainian masculine name ends to vowels without patronym: Mykola Ushko' );
ok( $M == &$d( 'Косой', 'Вася' ),
    'name of boy ends to vowels without patronym: Vasya Kosoy' );
ok( $M == &$d( 'Балаганов', 'Шура' ),
    'ambiguous name, detect by lastname: Shura Balaganov' );
ok( $M == &$d( 'Уолл', 'Ларри' ),
    'english masculine name: Larry Wall' );
ok( $M == &$d( 'Бах', 'Иоганн Себастьян' ),
    'german masculine name: Johann Sebastian Bach' );
ok( $M == &$d( 'фон Вебер', 'Карл Мария' ),
    'german masculine name: Carl Maria von Weber' );

# Feminine names
ok( $F == &$d( 'Волкова', 'Анна', 'Павловна' ),
    'usual russian feminine name: Anna Pavlovna Volkova' );
ok( $F == &$d( 'Соколова', 'Инна' ),
    'russian feminine name without patronym: Inna Sokolova' );
ok( $F == &$d( undef, 'Маргарита', 'Пална' ),
    'vulgar form of russian feminine firstname with patronym: Margarita Palna' );
ok( $F == &$d( 'Шевчук', 'Любовь' ),
    'russian feminine name ends to consonants: Lyubov Shevchuk' );
ok( $F == &$d( 'Купер', 'Элис' ),
    'english feminine name ends to consonants: Alice Cooper' );
ok( $F == &$d( 'Петрова', 'Женя' ),
    'ambiguous name, detect by lastname: Zhenya Petrova' );

# Ambigous names
ok( !defined( &$d( 'Кац', 'Саша' ) ),
    'ambiguous name: Sasha Katz' );

# Wrong names
# Just for fun
# ok( !defined( &$d( 'Хренова', 'Гадя', 'Петрович' ) ),
#     'wrong name: Gadya Petrovich Khrenova' );
