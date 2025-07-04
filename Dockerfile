FROM ruby:3.1.4

# 必要なパッケージをインストール
RUN apt-get update -qq && apt-get install -y \
  build-essential \
  libsass-dev \
  libpq-dev \
  postgresql-client \
  libvips \
  curl && \
  curl -sL https://deb.nodesource.com/setup_20.x | bash - && \
  apt-get install -y nodejs && \
  npm install --global yarn && \
  apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR /myapp

# Gemのインストール
COPY Gemfile Gemfile.lock /myapp/
RUN gem install bundler -v $(grep -A 1 "BUNDLED WITH" Gemfile.lock | tail -n 1) && \
  bundle install

# Node.jsパッケージのインストール
COPY package.json yarn.lock /myapp/
RUN yarn install

# アプリケーションコードのコピー
COPY . /myapp

# RuboCop設定のシンボリックリンク作成
RUN ln -sf /myapp/.rubocop.yml ~/.rubocop.yml

# エントリポイント設定
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]
