class Expls < Formula
  desc "ls with extension-based colors and modification-time gradients"
  homepage "https://github.com/kaikai-kitan/expls"
  url "https://github.com/kaikai-kitan/expls/archive/refs/tags/v0.1.2.tar.gz"
  sha256 "3d92b186cb33bae964b7f2528a3bf33c95347eff73f6543af75ef12eced72cdd" # ↓の手順で計算した値に置き換える
  license "MIT"
  head "https://github.com/kaikai-kitan/expls.git", branch: "main"

  depends_on "rust" => :build

  def install
    # Cargo.lock を尊重してビルドし、bin にインストールする
    # std_cargo_args は ["--locked", "--root", prefix, "--path", "."] に展開される
    system "cargo", "install", *std_cargo_args

    # `expls --completions` はカレントディレクトリの ./completions 以下に
    # 各シェル向け補完ファイルを生成する。それらを所定の場所へインストールする。
    system bin/"expls", "--completions"
    bash_completion.install "completions/bash/expls"
    zsh_completion.install  "completions/zsh/_expls"
    fish_completion.install "completions/fish/expls" => "expls.fish"
  end

  test do
    # このツールには --version が無いので --help の出力で動作確認する
    assert_match "extension-based colors", shell_output("#{bin}/expls --help")
  end
end
