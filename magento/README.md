# Basic settings

MySQL:

-> always set max_allowed_packet to fit your needs, eg:
max_allowed_packet = 16M 

PHP-FPM:

Always check those settings and update the values regarding the Env RAM and CPUs
pm = dynamic
pm.max_children = 100
pm.start_servers = 20
pm.min_spare_servers = 20
pm.max_spare_servers = 35
pm.max_requests = 500

Basic settings to keep an eye on, eg:

post_max_size = 10M
upload_max_filesize = 10M
max_input_vars = 1000
opcache.memory_consumption=128
opcache.interned_strings_buffer=8
opcache.max_accelerated_files=4000
opcache.revalidate_freq=60
opcache.fast_shutdown=1
opcache.enable_cli=1
opcache.save_comments=1
