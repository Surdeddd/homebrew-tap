class AgentWidgets < Formula
  desc "Native macOS desktop widgets built by AI agents"
  homepage "https://github.com/Surdeddd/agent-widgets"
  url "https://github.com/Surdeddd/agent-widgets/archive/refs/tags/v0.3.1.tar.gz"
  sha256 "c9e2b6c0fa9686a018509f99df4d80143e5f3dd041799c5c0847f9b36fe49478"
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
    system bin/"aw", "init", "--name", "Brew Test", "--bundle-prefix", "com.example.brewtest"
    system bin/"aw", "new", "probe", "--template", "metric"
    assert_path_exists testpath/"widgets/probe/widget.json"
    assert_path_exists testpath/"widgets/probe/ProbeView.swift"
  end
end
