#!/usr/bin/env perl
use strict;
use warnings;
use feature 'say';

my $arg = $ARGV[0] // '';
my @files;

if ($arg =~ /-[al]/) {
    @files = glob "* .*"; # 不可視ファイルも対象
    if ($arg eq '-l') {
        for (@files) {
            say $_ if -f; # ファイル一覧だけ表示
        }
        exit;
    }
}
else {
    @files = glob "*"; # 不可視ファイル外す
}

my %cats;
for (@files) {
    $cats{$_} = `cat $_` if -f;
}

say for (sort keys %cats);
say "===\n";

for (sort keys %cats) {
    say $_;
    say '---';
    say $cats{$_};
    say '';
}
