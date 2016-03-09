use warnings;
use strict;
use XML::Twig;

my $xmlstr = <<EOF;
<AGENT hostname="viper3">
 <LADDER>
  <ACL>
   <ACCOUNT id="4cf031986c">
    <USERNAME>emcon</USERNAME>
    <HOST>*sppcon*</HOST>
    <PERMISSION>CDOPS</PERMISSION>
   </ACCOUNT>
   <ACCOUNT id="b92794bbd7">
    <USERNAME>cpemcon</USERNAME>
    <HOST>*</HOST>
    <PERMISSION>COPS</PERMISSION>
   </ACCOUNT>
   <ACCOUNT id="8ff0478641">
    <USERNAME>dbemcon</USERNAME>
    <HOST>*</HOST>
    <PERMISSION>COPS</PERMISSION>
   </ACCOUNT>
   <ACCOUNT id="22d2647740">
   <USERNAME>tuxemcon</USERNAME>
    <HOST>*</HOST>
    <PERMISSION>COPS</PERMISSION>
    </ACCOUNT>
  </ACL>
 </LADDER>
</AGENT>
EOF

my $twig = XML::Twig->new(
    twig_handlers => {ACCOUNT => \&acct}
);
$twig->parse($xmlstr);

sub acct {
    my ($t, $elt) = @_;
    print $elt->att('id'), "\n";
    print $elt->first_child('USERNAME'  )->text(), "\n";
    print $elt->first_child('HOST'      )->text(), "\n";
    print $elt->first_child('PERMISSION')->text(), "\n";
    print "\n";
}