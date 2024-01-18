# AskMe

[Сервис](https://askme.ipirojnoe.ru), где можно задать вопрос и получить ответ

![Профиль AskMe](https://i.imgur.com/OyfFcBd.png)

| Десктоп  | Мобильная версия |
| ------------- | ------------- |
| ![AskMe](https://i.imgur.com/8RUAS2G.png)  | ![Мобильная AskMe](https://i.imgur.com/8kfkMus.png)  |


## Возможности

- Задать вопрос пользователю
- Задать вопрос пользователю *анонимно*
- Ответить на вопрос
- Посмотреть вопросы, в которых встречается определённый хэштэг
- Удалить профиль

## Установка и запуск

**Важно!** Необходимо получить токены для Recaptcha v2 `RECAPTCHA_SECRET_KEY`, `RECAPTCHA_SITE_KEY` и положить в `.env` в корне проекта, или `Config Vars` на Heroku

**1**. Клонирование репозитория 
```bash
git clone git@github.com:ipirojnoe/askme.git
cd askme
```

**2**.Установка Ruby 2.7.2

**3**. Установка гемов

```bash
gem install bundler:2.1.4
bundle install --without production
```

**4**. Установка NodeJS, Yarn и Webpacker

```bash
curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -
sudo apt install -y nodejs
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt update && sudo apt install -y yarn
rails webpacker:install
```

**5**. Запускаем миграции
```bash
bundle exec rails db:migrate
```


**6**. Запуск приложения

```bash
bundle exec rails s
```

## Лицензия

MIT
