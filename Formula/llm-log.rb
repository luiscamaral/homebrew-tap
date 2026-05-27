class LlmLog < Formula
  desc "Local proxy that tracks tokens, costs, prompts and responses across all LLM API calls"
  homepage "https://github.com/luiscamaral/llm.log"
  license "MIT"
  head "https://github.com/luiscamaral/llm.log.git", branch: "feat/litellm-provider"

  depends_on "go" => :build
  depends_on "node" => :build

  def install
    cd "web" do
      system "npm", "ci"
      system "npm", "run", "build"
    end
    ldflags = "-s -w -X github.com/lanesket/llm.log/internal/cli.Version=#{version}"
    system "go", "build", *std_go_args(ldflags: ldflags), "./cmd/llm-log"
  end

  test do
    system bin/"llm-log", "--version"
  end
end
