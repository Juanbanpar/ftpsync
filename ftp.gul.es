server {
  server_name gul.es ftp.gul.es;

  root /var/www/mirrors;
  autoindex on;
  sendfile on;
  sendfile_max_chunk 1m;
  tcp_nopush on;
  tcp_nodelay on;
  keepalive_timeout 65;
} 
