class AgentWidgets < Formula
  desc "Native macOS desktop widgets built by AI agents"
  homepage "https://github.com/Surdeddd/agent-widgets"
  url "https://github.com/Surdeddd/agent-widgets/archive/refs/tags/v0.3.0.tar.gz"
  sha256 "7d847a97ba3563efb8d1dd0438d7610d98d380d445269ed7d729171a383307de"
  license "MIT"
  head "https://github.com/Surdeddd/agent-widgets.git", branch: "main"

  depends_on xcode: ["16.3"]
  depends_on macos: :sonoma
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
