#!/bin/bash

export minimal_apt_get_args='-yqq --no-install-recommends'
export BUILD_PACKAGES="file bzip2 curl g++ gcc git libpq-dev make perl wget emacs install-info ca-certificates"
export PERL_PACKAGES="File::Slurp Moose JSON Method::Signatures::Simple Exporter::Easy DBI Bytes::Random::Secure Digest::SHA1 Crypt::Eksblowfish::Bcrypt Crypt::CBC indirect Readonly Clone Math::Random::MT Data::Password::Common Statistics::Descriptive CGI::PSGI Text::Diff Task::Plack DBD::Pg Crypt::Blowfish Text::Template"
export RUN_PACKAGES="perl git libpq-dev postgresql-9.4 postgresql-contrib-9.4 cron"