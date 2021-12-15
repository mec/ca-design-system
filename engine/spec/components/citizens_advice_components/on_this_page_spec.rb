# frozen_string_literal: true

require "rails_helper"

RSpec.describe OnThisPage, type: :component do
  let(:simple_links) do
    [
      { label: "Link 1", id: "link-1" },
      { label: "Link 2", id: "link-2" },
      { label: "Link 3", id: "link-3" },
      { label: "Link 4", id: "link-4" },
    ]
  end

  let(:nested_links) do
    [
      { label: "Link 1", id: "link-1" },
      { label: "Link 2", id: "link-2", children: [
        { label: "Link 2.1", id: "link-2-1" },
        { label: "Link 2.2", id: "link-2-2" },
      ]},
      { label: "Link 3", id: "link-3" },
      { label: "Link 4", id: "link-4", children: [
        { label: "Link 4.1", id: "link-4-1" },
      ]},
      { label: "Link 5", id: "link-5" },
    ]
  end

  let(:show_nested_links) { false }

  let(:subject) do
    component = OnThisPage.new(
      show_nested_links: show_nested_links,
    )
    render_inline(component)
  end

  context "when no links present" do
    let(:links) { nil }

    it "will not render anything" do
      expect(subject.children).to be_empty
    end
  end


  context "when there are links present" do
    let(:links) { simple_links }

    it "renders a list of top-level headings" do
      links = subject.css("[data-testid='on-this-page-link']")
      expect(links.map { |item| item.text.strip }).to eq [
        "An example level 2 heading",
        "A second level 2 heading example",
        "One more level 2 heading example"
      ]
    end

    it "does not render child links" do
      expect(subject.at("[data-testid='on-this-page-toggle']")).to be_nil
      expect(subject.at("[data-testid='on-this-page-children']")).to be_nil
    end
  end

  context "when show_nested_links is true" do
    let(:show_nested_links) { true }

    context "when there are only top-level headings present" do
      let(:body) { only_h2s }

      it "does not render child links" do
        expect(subject.at("[data-testid='on-this-page-toggle']")).to be_nil
        expect(subject.at("[data-testid='on-this-page-children']")).to be_nil
      end
    end

    context "when there are multiple heading levels present" do
      let(:body) { nested_h3s }

      it "renders a list of top-level headings" do
        links = subject.css("[data-testid='on-this-page-link']")
        expect(links.map { |item| item.text.strip }).to eq [
          "An example level 2 heading",
          "A second level 2 heading example",
          "One more level 2 heading example"
        ]
      end

      it "renders child links" do
        links = subject.css("[data-testid='on-this-page-child-link']")
        expect(links.map { |item| item.text.strip }).to eq ["A level 3 heading"]
        expect(subject.at("[data-testid='on-this-page-toggle']")).to_not be_nil
      end
    end
  end
end
