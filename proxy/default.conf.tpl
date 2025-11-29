server {
    listen 80;
    charset utf-8;

    # React build
    root /usr/share/nginx/html;
    index index.html;

    # SPA маршрутизация
    location / {
        try_files $uri /index.html;
    }
}


server {
    listen 8000;

    charset     utf-8;

    # Django media and static
    location /media/  {
        alias /vol/media/;
    }

    location /static/ {
        alias /vol/static/;
    }

    # Send all non-media requests to the Django server.
    # 0.0.0.1:9000
    location / {
        uwsgi_pass          ${APP_HOST}:${APP_PORT};
        include             /etc/nginx/uwsgi_params;
        client_max_body_size 40M;
    }
}
