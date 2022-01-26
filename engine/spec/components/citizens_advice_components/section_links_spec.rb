# frozen_string_literal: true

require "rails_helper"

RSpec.describe CitizensAdviceComponents::SectionLinks, type: :component do
  subject(:component) do
    render_inline described_class.new(title: "Related Content", section_title: "Applying to the EU settlement scheme",
                                      section_title_url: "/immigration#h-applying-to-the-eu-settlement-scheme") do |c|
      c.section_links(section_links)
    end
  end

  let(:section_links) do
    [
      { title: "Preparing to apply for pre-settled and settled status",
        url: "/immigration/preparing-to-apply-for-pre-settled-and-settled-status" },
      { title: "Applying for pre-settled and settled status", url: "/immigration/applying-for-settled-status" },
      { title: "Updating and proving your pre-settled or settled status", url: "/immigration/viewing-your-pre-settled-or-settled-status" },
      { title: "Switching from pre-settled to settled status", url: "/immigration/switching-from-pre-settled-to-settled-status" },
      { title: "Problems with your settled status decision", url: "/immigration/problems-with-your-settled-status-decision" }
    ]
  end

  it "renders the title" do
    expect(component.text.strip).to include "Related Content"
  end

  it "renders the section title" do
    expect(component.text.strip).to include "Applying to the EU settlement scheme"
  end

  it "renders a link for each sibling" do
    expect(component.css("[data-testid='section-links-link']").count).to eq section_links.count
  end

  context "when additional content present" do
    subject(:component) do
      render_inline described_class.new(title: "Related Content", section_title: "Applying to the EU settlement scheme",
                                        section_title_url: "/immigration#h-applying-to-the-eu-settlement-scheme") do |c|
        c.section_links(section_links)
        "Example content"
      end
    end

    it "renders the section title" do
      expect(component.text.strip).to include "Example content"
    end
  end

  context "when no links present" do
    subject(:component) do
      render_inline described_class.new(title: "Related Content", section_title: "Applying to the EU settlement scheme",
                                        section_title_url: "/immigration#h-applying-to-the-eu-settlement-scheme") do |c|
        c.section_links(nil)
        "Example content"
      end
    end

    it "does not render" do
      expect(component.at(".cads-section-links")).not_to be_present
    end
  end

  context "when no section title url present" do
    subject(:component) do
      render_inline described_class.new(title: "Related Content", section_title: "Applying to the EU settlement scheme") do |c|
        c.section_links(section_links)
        "Example content"
      end
    end

    it "does not render section title as a link" do
      expect(component.at("[data-testid='section-title-link']")).not_to be_present
    end
  end
end