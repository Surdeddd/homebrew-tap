class AgentWidgets < Formula
  desc "Native macOS desktop widgets built by AI agents"
  homepage "https://github.com/Surdeddd/agent-widgets"
  url "https://github.com/Surdeddd/agent-widgets/archive/refs/tags/v0.3.0.tar.gz"
  sha256 "8a2af78f7973de9d5347b55cdff6b652c1e3c5a0654ab7058d28c9ac2d26ff5f"
  license "MIT"
  head "https://github.com/Surdeddd/agent-widgets.git", branch: "main"

  depends_on macos: :sonoma
  depends_on xcode: ["16.3"]
  depends_on "xcodegen"

  def install
    system "swift", "build", "--disable-sandbox", "-c", "release", "--product", "aw"
    (libexec/"bin").install ".build/release/aw"
    libexec.install "Templates", "skills", "Kit"
    (bin/"aw").write_env_script libexec/"bin/aw", AW_HOME: opt_libexec
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/aw --version")
    assert_match "metric", shell_output("#{bin}/aw templates")
  end
end
