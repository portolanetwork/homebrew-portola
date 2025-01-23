# typed: false
# frozen_string_literal: true

# This file was generated by GoReleaser. DO NOT EDIT.
class PortolaApp < Formula
  desc ""
  homepage "https://github.com/portolanetwork/portola"
  version "0.6.29"
  depends_on :macos

  if Hardware::CPU.intel?
    url "https://github.com/portolanetwork/portola-release/releases/download/v0.6.29/portola_Darwin_x86_64.tar.gz"
    sha256 "15aa4acce725c75a40a0b1cfb389dd045d86d97e8cb591d3f25843f1dcf0592d"

    def install
      bin.install "portd"
      bin.install "portctl"
      prefix.install Dir["cmd/portd/deployment-assets/prod-usw1/resources"]
      prefix.install "cmd/portd/deployment-assets/prod-usw1/deployment.yaml"
    end
  end
  if Hardware::CPU.arm?
    url "https://github.com/portolanetwork/portola-release/releases/download/v0.6.29/portola_Darwin_arm64.tar.gz"
    sha256 "527cd98581fec60346b1c5bbcf0b87ca23ddb837bdfe84d15b2b04830ad91463"

    def install
      bin.install "portd"
      bin.install "portctl"
      prefix.install Dir["cmd/portd/deployment-assets/prod-usw1/resources"]
      prefix.install "cmd/portd/deployment-assets/prod-usw1/deployment.yaml"
    end
  end

  def caveats
    <<~EOS
      ****************************************************************
      Installed Portola Staging Formula. To start the service run:
        brew services start portola.app
      ****************************************************************
    EOS
  end

  service do
    run [opt_bin/"portd", "service", "start"]
    environment_variables(
      "BREW_APP_FORMULA_NAME" => "portola.app",
      "BREW_APP_BIN_PATH" => "#{bin}",
      "BREW_APP_OPT_HOME" => "#{opt_prefix}",
      "BREW_PREFIX" => "#{HOMEBREW_PREFIX}"
    )
    keep_alive true
    log_path "#{var}/log/portola.app/portd.out.log"
    error_log_path "#{var}/log/portola.app/portd.err.log"
    process_type :interactive
    working_dir opt_prefix
  end
end
