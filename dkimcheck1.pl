#!/usr/bin/perl -wT
use strict;

# verify a message
use Mail::DKIM::Verifier;

# create a verifier object
my $dkim = Mail::DKIM::Verifier->new();

# read an email from stdin, pass it into the verifier
while (<STDIN>)
{
 # remove local line terminators
 chomp;
 s/\015$//;

 # use SMTP line terminators
 $dkim->PRINT("$_\015\012");
}
$dkim->CLOSE;

# what is the result of the verify?
my $result = $dkim->result;
my $detail = $dkim->result_detail;

print "Result: " . $result . "\n";
print "Detail: " . $detail . "\n";
