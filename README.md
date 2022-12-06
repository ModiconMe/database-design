### DATABASE DESIGN COURSE

Спроектировали таблицы для базы данных клона YouTube. 

technology:
* postgresql
* diagram.net

Сущности:
* user_profile
* youtube_account
* youtube_channel
* channel_subscriber 
* video
* video_view
* video_comment
* video_like
* video_comment_like

Описание отношений
* у одного user_profile может быть только один youtube_account (one to one)
* один youtube_account может зарегистрировать множество youtube_channel (one to many)
* youtube_account могут подписываться на youtube_channel, при этом только один раз (composite primary key). Bridge-table -- channel-subscriber(many to many).
* видео video выкладывают каналы youtube_channels(one to many), но смотрят video_view, лайкают video_like, комментируют video_comment с youtube_account (one to many). 
* смотреть видео video_view можно и без youtube_account (one or zero to many).
* лайкать комментарии video_comment_like с youtube_account(one to many).

![alt text](https://github.com/ModiconMe/database-design/blob/main/databases.svg "database")