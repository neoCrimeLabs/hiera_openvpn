# How I'm using hiera here

This is my hiera configuration at the time of writing:

    :hierarchy:
        - hieradata/common/%{calling_module}
        - modules/%{calling_module}/hieradata/default_settings
    :backends:
        - yaml
    :yaml:
        :datadir: '/etc/puppet'
    :logger: console
    :puppet:
        :datasource: data

I did this to eliminate the need for params.pp and replaced manifest logic with pure hiera.  It you want your setting to take priority, simply add it to your common/%{calling_module}.yaml file.
