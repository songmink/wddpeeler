#!/usr/bin/perl

use Parse::MediaWikiDump;
use DBI;
use DBD::mysql;

$server         = "localhost";
$name           = "dbname";
$user           = "admin";
$password       = "pass";

$dsn = "DBI:mysql:database=$name;host=$server;";
$dbh = DBI->connect($dsn, $user, $password);

$source = 'pages_articles.xml';

$pages = Parse::MediaWikiDump::Pages->new($source);
print "Done parsing.\n";

while(defined($page = $pages->page)) {
    $c = $page->categories;
    if (grep {/Mathematics/} @$c) {  # all categories with the string "Mathematics" anywhere in their text. 
                                     # For exact match, use {$_ eq "Mathematics"}

        $id = $page->id;
        $title = $page->title;
        $text = $page->text;

        #$dbh->do("insert ..."); #details of SQL depend on the database setup

        print "title '$title' id $id was inserted.\n";
    }
}