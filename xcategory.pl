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

$source = '/mnt/repo/eget/enwiki/enwiki-20160204-pages-meta-history1.xml';

$pages = Parse::MediaWikiDump::Pages->new($source);
print "Done parsing.\n";

while(defined($page = $pages->page)) {
    $c = $page->categories;
    if (grep {/Mathermatics/} @$c) {  # all categories with the string "Mathermatics" anywhere in their text. 
                                     # For exact match, use {$_ eq "Mathematics"}

        $id = $page->id;
        $title = $page->title;
		#$text = $page->text;

        $dbh->do("insert into category (id, title) value ($id, $title)"); #details of SQL depend on the database setup
        print "title '$title' id $id was inserted.\n";
    }
}