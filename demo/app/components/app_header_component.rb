# frozen_string_literal: true

class AppHeaderComponent < ViewComponent::Base
  def navigation_links
    [
      { url: "/benefits/", title: "Benefits" },
      { url: "/work/", title: "Work" },
      { url: "/debt-and-money/", title: "Debt and money" },
      { url: "/consumer/", title: "Consumer" },
      { url: "/housing/", title: "Housing" },
      { url: "/family/", title: "Family" },
      { url: "/law-and-courts/", title: "Law and courts" },
      { url: "/immigration/", title: "Immigration" },
      { url: "/health/", title: "Health" },
      { url: "/more", title: "More from us" }
    ]
  end

  def header_links
    [
      { title: "Public site", url: "/", current_site: true },
      { title: "AdviserNet", url: "?advisernet" },
      { title: "CABlink", url: "?CABlink" },
      { title: "BMIS", url: "?BMIS" },
      { title: "Cymraeg", url: "?lang=cy" }
    ]
  end
end
