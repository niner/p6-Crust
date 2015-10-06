use v6;
use Test;

use lib 't/lib/';
use Test::TCP;
use Crust::Handler::HST;
use HTTP::Tinyish;

my $port = 15555;

Thread.start({
    my $handler = Crust::Handler::HST.new(
        host => '127.0.0.1',
        port => $port
    );
    $handler.run(-> $env {
        200, [], ['ok'.encode('utf-8')]
    });
});

wait_port($port);

my $resp = HTTP::Tinyish.new().get("http://127.0.0.1:$port/");
ok $resp<success>;
is $resp<content>, 'ok';

done-testing;
