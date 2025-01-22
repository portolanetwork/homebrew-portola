# typed: false
# frozen_string_literal: true

# This file was generated by GoReleaser. DO NOT EDIT.
class PortolaApp < Formula
  desc ""
  homepage "https://github.com/portolanetwork/portola"
  version "0.6.23"
  depends_on :macos

  if Hardware::CPU.intel?
    url "https://github.com/portolanetwork/portola-release/releases/download/v0.6.23/portola_Darwin_x86_64.tar.gz"
    sha256 "3e344ff2587f46faba94f523230ef6bc4329992db5e4c1a9d919235309fe1bec"

    def install
      bin.install "portd"
      bin.install "portctl"
      prefix.install Dir["cmd/portd/config/prod-usw1/resources"]
      prefix.install "cmd/portd/config/prod-usw1/deployment.yaml"
    end
  end
  if Hardware::CPU.arm?
    url "https://github.com/portolanetwork/portola-release/releases/download/v0.6.23/portola_Darwin_arm64.tar.gz"
    sha256 "55647399b94236fb25e8b64ec2bcd189a323a89169467d68cb0dbd14cbd13c30"

    def install
      bin.install "portd"
      bin.install "portctl"
      prefix.install Dir["cmd/portd/config/prod-usw1/resources"]
      prefix.install "cmd/portd/config/prod-usw1/deployment.yaml"
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
