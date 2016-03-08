#!/usr/bin/perl

use Parse::MediaWikiDump;
use DBI;
use DBD::mysql;

$server         = "localhost";
$name           = "wikidb";
$user           = "wikidb";
$password       = "wikidb";

$dsn = "DBI:mysql:database=$name;host=$server;";
$dbh = DBI->connect($dsn, $user, $password);

$source = 'pages_articles.xml';

$pages = Parse::MediaWikiDump::Pages->new($source);
print "Done parsing.\n";

while(defined($page = $pages->page)) {

        $id = $page->id;
        $title = $page->title;
        $text = $page->text;

        $dbh->do("insert ..."); #details of SQL depend on the database setup

        print "title '$title' id $id was inserted.\n";
    }
}