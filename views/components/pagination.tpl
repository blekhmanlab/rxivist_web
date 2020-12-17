% import math
% # if there's more than one page of results, to keep
% # display the "previous" button even if it's page one,
% # the page numbers from changing positions along the
% # bottom between pages 0 and 1
% if totalcount > page_size:
  <a href="{{pagelink}}{{ page - 1 }}" rel="nofollow" class="btn btn-altcolor
  % if page == 0:
    disabled
  % end
  ">Previous page</a>

% if page > 0: # always give a link to the first page of results
  <a class="pagenum" href="{{pagelink}}0" rel="nofollow" class="btn btn-altcolor">1</a>
% end

% if page > 4: # if there's a gap between the previous page numbers we print and the first page:
  <span class="pagenum">. . .</span>
% elif page == 4: # if the ellipsis would only eliminate one number, just print the page number:
  <a class="pagenum" href="{{pagelink}}1" rel="nofollow" class="btn btn-altcolor">2</a>
% end

% if page > 2:
  <a class="pagenum" href="{{pagelink}}{{ page - 2 }}" rel="nofollow" class="btn btn-altcolor">{{ page - 1 }}</a>
% end
% if page > 1:
  <a class="pagenum" href="{{pagelink}}{{ page - 1 }}" rel="nofollow" class="btn btn-altcolor">{{ page }}</a>
% end

% if totalcount > page_size:  # if there's more than one page of results, print the current page
<span class="pagenum"><strong>{{ page + 1 }}</strong></span>

% maxpages = 5
% page_nums_printed = 0
% for i in range(1, maxpages):
  % if (page + i) * page_size < totalcount:
    <a class="pagenum" href="{{pagelink}}{{ page + i }}" rel="nofollow" class="btn btn-altcolor">{{ page + i + 1 }}</a>
    % page_nums_printed += 1
  % end
% end

% last_printed = page + page_nums_printed + 1
% lastpage = math.ceil(totalcount / page_size) - 1

% if last_printed < lastpage: # if the final page printed isn't the last page

  % if last_printed  < lastpage - 1: # if there's a gap before the last page number
    <span class="pagenum">. . .</span>
  % # if the ellipsis would only eliminate one number, just print the page number:
  % elif last_printed  == lastpage - 1:
    <a class="pagenum" href="{{pagelink}}{{ lastpage - 1 }}" rel="nofollow" class="btn btn-altcolor">{{ lastpage }}</a>
  % end
  <a class="pagenum" href="{{pagelink}}{{ lastpage }}" rel="nofollow" class="btn btn-altcolor">{{ lastpage  + 1 }}</a>
% end

% if page < lastpage:
  <a href="{{pagelink}}{{ page + 1 }}" rel="nofollow" class="btn btn-altcolor">Next page</a>
% end
