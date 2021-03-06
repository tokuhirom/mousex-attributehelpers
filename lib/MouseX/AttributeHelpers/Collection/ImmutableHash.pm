package MouseX::AttributeHelpers::Collection::ImmutableHash;

use Mouse;

extends 'MouseX::AttributeHelpers::Base';

has '+method_constructors' => (
    default => sub {
        return +{
            exists => sub {
                my ($attr, $name) = @_;
                return sub { CORE::exists $_[0]->$name()->{$_[1]} ? 1 : 0 };
            },
            get => sub {
                my ($attr, $name) = @_;
                return sub { @_ == 2 ? $_[0]->$name()->{$_[1]} : @{ CORE::shift->$name() }{@_} };
            },
            keys => sub {
                my ($attr, $name) = @_;
                return sub { CORE::keys %{ $_[0]->$name() } };
            },
            values => sub {
                my ($attr, $name) = @_;
                return sub { CORE::values %{ $_[0]->$name() } };
            },
            kv => sub {
                my ($attr, $name) = @_;
                return sub {
                    my $h = $_[0]->$name();
                    map { [ $_, $h->{$_} ] } CORE::keys %$h;
                };
            },
            count => sub {
                my ($attr, $name) = @_;
                return sub { scalar CORE::keys %{ $_[0]->$name() } };
            },
            empty => sub {
                my ($attr, $name) = @_;
                return sub { scalar CORE::keys %{ $_[0]->$name() ? 1 : 0 };
            },
        };
    },
);

no Mouse;

package # hide from PAUSE
    Mouse::Meta::Attribute::Custom::Collection::ImmutableHash;
sub register_implementation { 'MouseX::AttributeHelpers::Collection::ImmutableHash' }

1;
