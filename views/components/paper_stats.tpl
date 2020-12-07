% import helpers

% if "ranks" not in paper.keys() or helpers.formatNumber(paper["ranks"]["alltime"]["downloads"]) == "None":
<p><em>No download data for this paper yet.</em></p>
% else:
<ul>
  <li><em>Downloaded {{ helpers.formatNumber(paper["ranks"]["alltime"]["downloads"]) }} times</em>
  <li><strong>Download rankings, all-time:</strong>
    <ul>
      <li>Site-wide: <strong>{{ helpers.formatNumber(paper["ranks"]["alltime"]["rank"]) }}</strong></li>
      % if paper["category"] != "unknown":
        <li>In {{ helpers.formatCategory(paper["category"]) }}: <strong>{{ helpers.formatNumber(paper["ranks"]["category"]["rank"]) }}</strong></li>
      % end
    </ul>
  </li>
  <li><strong>Year to date</strong>:
    <ul>
      <li>Site-wide: <strong>{{ helpers.formatNumber(paper["ranks"]["ytd"]["rank"]) }}</strong></li>
    </ul>
  </li>
  <li><strong>Since beginning of last month</strong>:
    <ul>
      <li>Site-wide: <strong>{{ helpers.formatNumber(paper["ranks"]["lastmonth"]["rank"]) }}</strong></li>
    </ul>
  </li>
</ul>
% end