# ベースイメージとしてRuby 3.2.1から3.1.４
FROM ruby:3.1.4

# 必要なパッケージをインストール
RUN apt-get update -qq && apt-get install -y \
  build-essential \
  libpq-dev \
  postgresql-client \
  libvips \
  curl && \
  curl -sL https://deb.nodesource.com/setup_20.x | bash - && \
  apt-get install -y nodejs && \
  npm install --global yarn && \
  apt-get clean && rm -rf /var/lib/apt/lists/*

# 作業ディレクトリを作成
WORKDIR /myapp

# GemfileとGemfile.lockをコピーして依存関係をインストール
COPY Gemfile Gemfile.lock /myapp/
RUN gem install bundler && bundle install

# package.jsonとyarn.lockをコピーして依存関係をインストール
COPY package.json yarn.lock /myapp/
RUN yarn install


# 必要なパッケージを更新し、libvipsをインストールする
RUN apt-get update -qq && apt-get install -y build-essential libvips

COPY . /myapp

# エントリポイントスクリプトの追加
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

# ポート3000を公開
EXPOSE 3000

# サーバー起動コマンド
CMD ["rails", "server", "-b", "0.0.0.0"]
