# frozen_string_literal: true

require 'zip'

namespace :project do
  desc 'プロジェクト全体をZIPファイルに圧縮'
  task zip: :environment do
    # プロジェクトディレクトリとZIPファイルの出力先
    project_dir = Rails.root.to_s
    output_file = "#{File.basename(project_dir)}.zip"

    # 除外するディレクトリとファイル
    excludes = ['.git', 'tmp', 'log', 'storage', 'node_modules', '.bundle']

    puts "ZIPファイルを作成中: #{output_file}"

    Zip::File.open(output_file, Zip::File::CREATE) do |zipfile|
      Dir.glob("#{project_dir}/**/*").each do |file|
        next if excludes.any? { |e| file.include?(e) }
        next if File.directory?(file)

        # ZIPファイル内のパスを相対パスに変換
        zip_path = file.sub("#{project_dir}/", '')
        zipfile.add(zip_path, file)
      end
    end

    puts "ZIPファイルが作成されました: #{output_file}"
  end
end
