#!/usr/bin/perl -wT
#
use strict;
use warnings;

use Mail::DKIM::Verifier;

# create a verifier object
my $dkim = Mail::DKIM::Verifier->new();

# read an email from a file handle
#use FileHandle;
#my $fh = FileHandle->new("test.eml", "r");
#if (defined $fh) {
#  $dkim->load($fh);
#  $fh->close; 
#}
#else {
#  print "No email-file found!\n";
#  exit (1);
#}

# or read an email and pass it into the verifier, incrementally
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

# there might be multiple signatures, what is the result per signature?
foreach my $signature ($dkim->signatures)
{
print "signature identity: " . $signature->identity . "\n";
print "verify result: " . $signature->result_detail . "\n";
}

# the alleged author of the email may specify how to handle email
foreach my $policy ($dkim->policies)
{
die "fraudulent message" if ($policy->apply($dkim) eq "reject");
}

