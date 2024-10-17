# ベースイメージとしてNode.jsとRubyを使用
FROM node:20 as node
FROM ruby:3.2.1

# Node.jsとYarnの関連ファイルをコピー
COPY --from=node /opt/yarn-* /opt/yarn
COPY --from=node /usr/local/bin/node /usr/local/bin/
COPY --from=node /usr/local/lib/node_modules/ /usr/local/lib/node_modules/
RUN ln -fs /usr/local/lib/node_modules/npm/bin/npm-cli.js /usr/local/bin/npm \
  && ln -fs /usr/local/lib/node_modules/npm/bin/npm-cli.js /usr/local/bin/npx \
  && ln -fs /opt/yarn/bin/yarn /usr/local/bin/yarn \
  && ln -fs /opt/yarn/bin/yarnpkg /usr/local/bin/yarnpkg

# 必要なパッケージのインストール
RUN apt-get update -qq && \
  apt-get install -y build-essential \
  libpq-dev \
  postgresql-client \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

# 作業ディレクトリの作成
RUN mkdir /myapp
WORKDIR /myapp

# GemfileとGemfile.lockをコピーして依存関係をインストール
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
RUN bundle install

# package.jsonとyarn.lockをコピーして依存関係をインストール
COPY package.json yarn.lock ./
RUN yarn install

# libvipsのインストール（画像処理のため）
RUN apt-get update && apt-get install -y libvips

# アプリケーションの全ファイルをコピー
COPY . /myapp

# エントリポイントスクリプトの追加
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

# ポート3000を公開
EXPOSE 3000

# メインプロセスの起動
CMD ["rails", "server", "-b", "0.0.0.0"]
