class AgentWidgets < Formula
  desc "Native macOS desktop widgets built by AI agents"
  homepage "https://github.com/Surdeddd/agent-widgets"
  url "https://github.com/Surdeddd/agent-widgets/archive/refs/tags/v0.3.0.tar.gz"
  sha256 "03c6016613e9de83c0e5e9b1de316f9fb0c436d41a00514e5ada5be8bc9ae063"
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
