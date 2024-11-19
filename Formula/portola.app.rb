# typed: false
# frozen_string_literal: true

# This file was generated by GoReleaser. DO NOT EDIT.
class PortolaApp < Formula
  desc ""
  homepage "https://github.com/nomad10101/portola"
  version "0.4.7"
  depends_on :macos

  url "https://github.com/portolanetwork/portola-release/releases/download/v0.4.7/portola.app_Darwin_x86_64.tar.gz"
  sha256 "ba75211a30ea42f7e548b95f5349d0d62295f349bea16e887c7ae64b2bee60b4"

  def install
    bin.install "portd"
    bin.install "portctl"
    prefix.install Dir["cmd/portd/config/ci/resources"]
    prefix.install "cmd/portd/config/ci/deployment.yaml"
  end

  on_arm do
    def caveats
      <<~EOS
        The darwin_arm64 architecture is not supported for the PortolaApp
        formula at this time. The darwin_amd64 binary may work in compatibility
        mode, but it might not be fully supported.
      EOS
    end
  end

  def caveats
    <<~EOS
      ****************************************************************
      Listen up...
      ****************************************************************
    EOS
  end

  service do
    run [opt_bin/"portd", "service", "start"]
    environment_variables BREW_OPT_HOME: opt_prefix
    keep_alive true
    log_path "#{var}/log/portd/portd.out.log"
    error_log_path "#{var}/log/portd/portd.err.log"
    process_type :interactive
    working_dir opt_prefix
  end
end
