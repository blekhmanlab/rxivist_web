% import helpers

% if "ranks" not in paper.keys() or helpers.formatNumber(paper["ranks"]["alltime"]["downloads"]) == "None":
<p><em>No bioRxiv download data for this paper yet.</em></p>
% else:
<ul>
  <li><strong>Download rankings, all-time:</strong>
    <ul>
      <li>Site-wide: <strong>{{ helpers.formatNumber(paper["ranks"]["alltime"]["rank"]) }}</strong> out of {{ helpers.formatNumber(paper["ranks"]["alltime"]["out_of"]) }}</li>
      <li>In {{ helpers.formatCategory(paper["category"]) }}: <strong>{{ helpers.formatNumber(paper["ranks"]["category"]["rank"]) }}</strong> out of {{ helpers.formatNumber(paper["ranks"]["category"]["out_of"]) }}</li>
    </ul>
  </li>
  <li><strong>Download rankings, year to date</strong>:
    <ul>
      <li>Site-wide: <strong>{{ helpers.formatNumber(paper["ranks"]["ytd"]["rank"]) }}</strong> out of {{ helpers.formatNumber(paper["ranks"]["ytd"]["out_of"]) }}</li>
    </ul>
  </li>
  <li><strong>Download rankings since beginning of last month</strong>:
    <ul>
      <li>Site-wide: <strong>{{ helpers.formatNumber(paper["ranks"]["lastmonth"]["rank"]) }}</strong> out of {{ helpers.formatNumber(paper["ranks"]["lastmonth"]["out_of"]) }}</li>
    </ul>
  </li>
</ul>
% end