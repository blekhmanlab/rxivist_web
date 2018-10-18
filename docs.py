import config
import docmodels
import helpers

def build_docs():
  category_list = helpers.rxapi("/v1/data/categories")["results"] # list of all article categories

  return docmodels.Documentation("https://api.rxivist.org/v1",
    [
      papers(category_list),
      authors(category_list),
      apidetails(),
    ]
  )

def papers(category_list):
  papers = docmodels.Chapter("Papers", "Search all bioRxiv papers and retrieve details.")
  query = papers.add_endpoint("Search", "/papers", "Retrieve a list of papers matching the given criteria.")
  query.add_argument("get", "query", "A search string to filter results based on their titles, abstracts and authors.", "")

  metric = query.add_argument("get", "metric", "Which field to use when sorting results.", "twitter")
  metric.add_values(["downloads", "twitter"])

  timeframe = query.add_argument("get", "timeframe", "How far back to look for the cumulative results of the chosen metric. (\"ytd\" and \"lastmonth\" are only available for the \"downloads\" metric.", "\"day\" for Twitter metrics, \"alltime\" for downloads.")
  timeframe.add_values(["alltime", "ytd", "lastmonth", "day", "week", "month", "year"])

  catfilter = query.add_argument("get", "category_filter", "An array of categories to which the results should be limited.", "[]")
  catfilter.add_values(category_list)

  query.add_argument("get", "page", "Number of the page of results to retrieve. Shorthand for an offset based on the specified page_size", 0)

  query.add_argument("get", "page_size", "How many results to return at one time. Capped at {}.".format(config.max_page_size_api), 20)

  query.add_example(
    "Top 3 downloaded papers, all time",
    "Using the \"downloads\" metric, get 3 papers ordered by their overall download count.",
    "/papers?metric=downloads&page_size=3&timeframe=alltime",
    """{
  "query": {
    "text_search": "",
    "timeframe": "alltime",
    "categories": [],
    "metric": "downloads",
    "page_size": 3,
    "current_page": 0,
    "final_page": 11138
  },
  "results": [
    {
      "id": 12345,
      "metric": 166288,
      "title": "Example Paper Here: A compelling placeholder",
      "url": "https://www.biorxiv.org/content/early/2018/fake_url",
      "doi": "10.1101/00000",
      "category": "cancer-biology",
      "first_posted": "19-09-18",
      "abstract": "This is where the abstract would go.",
      "authors": [
        {
          "id": 1,
          "name": "Richard Abdill"
        },
        {
          "id": 24802,
          "name": "Another Person"
        }
      ]
    },
    {
      "id": 12346,
      "metric": 106169,
      "title": "Deep image reconstruction from human brain activity",
      "url": "https://www.biorxiv.org/content/early/2017/12/30/240317",
      "doi": "10.1101/240317",
      "category": "neuroscience",
      "first_posted": "28-12-2017",
      "abstract": "Machine learning-based analysis of human functional magnetic resonance imaging (fMRI) patterns has enabled the visualization of perceptual content. However, it has been limited to the reconstruction with low-level image bases or to the matching to exemplars. Recent work showed that visual cortical activity can be decoded (translated) into hierarchical features of a deep neural network (DNN) for the same input image, providing a way to make use of the information from hierarchical visual features. Here, we present a novel image reconstruction method, in which the pixel values of an image are optimized to make its DNN features similar to those decoded from human brain activity at multiple layers. We found that the generated images resembled the stimulus images (both natural images and artificial shapes) and the subjective visual content during imagery. While our model was solely trained with natural images, our method successfully generalized the reconstruction to artificial shapes, indicating that our model indeed reconstructs or generates images from brain activity, not simply matches to exemplars. A natural image prior introduced by another deep neural network effectively rendered semantically meaningful details to reconstructions by constraining reconstructed images to be similar to natural images. Furthermore, human judgment of reconstructions suggests the effectiveness of combining multiple DNN layers to enhance visual quality of generated images. The results suggest that hierarchical visual information in the brain can be effectively combined to reconstruct perceptual and subjective images.",
      "authors": [
        "Guohua Shen",
        "Tomoyasu Horikawa",
        "Kei Majima",
        "Yukiyasu Kamitani"
      ]
    },
    {
      "id": 12347,
      "metric": 99096,
      "title": "Could a neuroscientist understand a microprocessor?",
      "url": "https://www.biorxiv.org/content/early/2016/11/14/055624",
      "doi": "10.1101/055624",
      "category": "neuroscience",
      "first_posted": "26-05-2016",
      "abstract": "There is a popular belief in neuroscience that we are primarily data limited, and that producing large, multimodal, and complex datasets will, with the help of advanced data analysis algorithms, lead to fundamental insights into the way the brain processes information. These datasets do not yet exist, and if they did we would have no way of evaluating whether or not the algorithmically-generated insights were sufficient or even correct. To address this, here we take a classical microprocessor as a model organism, and use our ability to perform arbitrary experiments on it to see if popular data analysis methods from neuroscience can elucidate the way it processes information. Microprocessors are among those artificial information processing systems that are both complex and that we understand at all levels, from the overall logical flow, via logical gates, to the dynamics of transistors. We show that the approaches reveal interesting structure in the data but do not meaningfully describe the hierarchy of information processing in the microprocessor. This suggests current analytic approaches in neuroscience may fall short of producing meaningful understanding of neural systems, regardless of the amount of data. Additionally, we argue for scientists using complex non-linear dynamical systems with known ground truth, such as the microprocessor as a validation platform for time-series and structure discovery methods.",
      "authors": [
        {
          "id": 1,
          "name": "Richard Abdill"
        },
        {
          "id": 24802,
          "name": "Another Person"
        }
      ]
    }
  ]
}
    """
  )

  details = papers.add_endpoint("Details", "/papers/<id>", "Retrieve data about a single paper and all of its authors. Note: Unlike the author rankings, paper rankings do NOT incorporate the concept of ties.")
  details.add_argument("path", "id", "Rxivist paper ID associated with the paper you want ", required=True)
  details.add_example(
    "Paper detail request",
    "",
    "/papers/25777",
    """{
  "id": 25770,
  "doi": "10.1101/096727",
  "biorxiv_url": "https://www.biorxiv.org/content/early/2016/12/29/096727",
  "url": "https://rxivist.org/papers/25770",
  "title": "Parallel adaptation to higher temperatures in divergent clades of the nematode Pristionchus pacificus",
  "category": "evolutionary-biology",
  "first_posted": "2016-12-29",
  "abstract": "Studying the effect of temperature on fertility is particularly important in the light of ongoing climate change. We need to know if organisms can adapt to higher temperatures and, if so, what are the evolutionary mechanisms behind such adaptation. Such studies have been hampered by the lack different populations of sufficient sizes with which to relate the phenotype of temperature tolerance to the underlying genotypes. Here, we examined temperature adaptation in populations of the nematode Pristionchus pacificus, in which individual strains are able to successfully reproduce at 30°C. Analysis of the frequency of heat tolerant strains in different temperature zones on La Reunion supports that this trait is subject to natural selection. Reconstruction of ancestral states along the phylogeny of highly differentiated P. pacificus clades suggests that heat tolerance evolved multiple times independently. This is further supported by genome wide association studies showing that heat tolerance is a polygenic trait and that different loci are used by individual P. pacificus clades to develop heat tolerance. More precisely, analysis of allele frequencies indicated that most genetic markers that are associated with heat tolerance are only polymorphic in individual clades. While in some P. pacificus clades, parallel evolution of heat tolerance can be explained by ancestral polymorphism or by gene flow across clades, we observe at least one clearly distinct and independent scenario where heat tolerance emerged by de novo mutation. Thus, temperature tolerance evolved at least two times independently in the evolutionary history of this species. Our data suggest that studies of wild populations of P. pacificus will reveal distinct cellular mechanisms driving temperature adaptation.",
  "authors": [
    {
      "id": 1221,
      "name": "Mark Leaver",
      "institution": "Max Planck Institute of Molecular Cell Biology and Genetics;",
      "orcid": "http://orcid.org/0000-0003-2796-4312"
    },
    {
      "id": 1222,
      "name": "Merve Kayhan",
      "institution": "Bilkent University;",
      "orcid": null
    },
    {
      "id": 1223,
      "name": "Angela McGaughran",
      "institution": "Australian National University;",
      "orcid": null
    },
    {
      "id": 1224,
      "name": "Christian Roedelsperger",
      "institution": "Max Planck Institute for Developmental Biology;",
      "orcid": null
    },
    {
      "id": 1225,
      "name": "Anthony A Hyman",
      "institution": "Max Planck Institute of Molecular Cell Biology and genetics",
      "orcid": "http://orcid.org/0000-0003-3664-154X"
    },
    {
      "id": 1226,
      "name": "Ralf Sommer",
      "institution": "Max Planck Institute for Developmental Biology;",
      "orcid": "http://orcid.org/0000-0003-1503-7749"
    }
  ],
  "ranks": {
    "alltime": {
      "rank": 15658,
      "tie": false,
      "downloads": 290
    },
    "ytd": {
      "rank": 22951,
      "tie": false,
      "downloads": 65
    },
    "lastmonth": {
      "rank": 28283,
      "tie": 4,
      "downloads": 65
    },
    "category": {
      "rank": 1500,
      "tie": 4,
      "downloads": 290
    }
  },
  publication": {
    "journal": "Journal Name Here",
    "doi": "10.1038/1234567"
  }
}
    """
  )

  downloads = papers.add_endpoint("Download data", "/papers/<id>/downloads", "Retrieve monthly download statistics for a single paper. PLEASE NOTE that currently, the author list for a given paper is based on the authors retrieved the first time a paper was indexed by Rxivist; if a paper was revised later and the author list modified, that would not have been updated here.")
  downloads.add_argument("path", "id", "Rxivist paper ID associated with the download data you want.", required=True)
  downloads.add_example(
    "Paper download data request",
    "",
    "/papers/12345/downloads",
    """{
  "query": {
    "id": 12345
  },
  "results": [
    {
      "month": 6,
      "year": 2018,
      "downloads": 205
    },
    {
      "month": 7,
      "year": 2018,
      "downloads": 153
    },
    {
      "month": 8,
      "year": 2018,
      "downloads": 88
    },
    {
      "month": 9,
      "year": 2018,
      "downloads": 118
    },
    {
      "month": 10,
      "year": 2018,
      "downloads": 10
    }
  ]
}
    """
  )

  return papers

def authors(category_list):
  authors = docmodels.Chapter("Authors", "Retrieving more detailed information about a single author.")

  ranks = authors.add_endpoint("Rankings", "/authors", "The top 200 authors for all-time downloads in a category.")
  catlimit = ranks.add_argument("get", "category", "The category to which results should be limited. Omitting one returns results for the entire site.")
  catlimit.add_values(category_list)
  ranks.add_example(
    "Author rankings request, limited to biophysics",
    "",
    "/authors?category=biophysics",
    """{
  "results": [
    {
      "id": 80168,
      "name": "Claudia Cattoglio",
      "rank": 1,
      "downloads": 2504,
      "tie": true
    },
    {
      "id": 47439,
      "name": "Xavier Darzacq",
      "rank": 1,
      "downloads": 2504,
      "tie": true
    },
    {
      "id": 47441,
      "name": "Robert Tjian",
      "rank": 1,
      "downloads": 2504,
      "tie": true
    },
    {
      "id": 19704,
      "name": "Patrick Cramer",
      "rank": 4,
      "downloads": 2389,
      "tie": false
    },
    {
      "id": 80823,
      "name": "Dimitry Tegunov",
      "rank": 5,
      "downloads": 2388,
      "tie": true
    },
    # ...and so on for 200 entries
  ]
}
"""
  )

  details = authors.add_endpoint("Details", "/authors/<id>", "Retrieve data about a single author.")
  details.add_argument("path", "id", "Rxivist paper ID associated with the author in question.", required=True)
  details.add_example(
    "Author detail request",
    "",
    "/authors/1222",
    """{
  "id": 1222,
  "name": "Merve Kayhan",
  "institution": "Bilkent University;",
  "orcid": null,
  "emails": [
    "merve.kayhan@bilkent.edu.tr"
  ],
  "articles": [
    {
      "id": 25770,
      "doi": "10.1101/096727",
      "biorxiv_url": "https://www.biorxiv.org/content/early/2016/12/29/096727",
      "url": "https://rxivist.org/papers/25770",
      "title": "Parallel adaptation to higher temperatures in divergent clades of the nematode Pristionchus pacificus",
      "category": "evolutionary-biology",
      "ranks": {
        "alltime": {
          "rank": 15658,
          "tie": false,
          "downloads": 290
        },
        "ytd": {
          "rank": 22951,
          "tie": false,
          "downloads": 65
        },
        "lastmonth": {
          "rank": 28283,
          "tie": 4,
          "downloads": 65
        },
        "category": {
          "rank": 28283,
          "tie": 4,
          "downloads": 0
        }
      }
    }
  ],
  "ranks": [
    {
      "downloads": 134075,
      "rank": 1,
      "out_of": 104795,
      "tie": false,
      "category": "alltime"
    },
    {
      "downloads": 3126,
      "rank": 1120,
      "out_of": 14752,
      "tie": true,
      "category": "bioinformatics"
    },
    {
      "downloads": 130949,
      "rank": 1,
      "out_of": 21996,
      "tie": false,
      "category": "neuroscience"
    }
  ]
}
    """
  )
  return authors

def apidetails():
  api = docmodels.Chapter("API details", "Summary information about the Rxivist data.")
  categories = api.add_endpoint("Category list", "/data/categories", "A list of all bioRxiv \"collections,\" or categories, currently available via Rxivist.")
  categories.add_example(
    "",
    "",
    "/data/categories",
    """{
  "results": [
    "animal-behavior-and-cognition",
    "biochemistry",
    "bioengineering",
    "bioinformatics",
    "biophysics",
    "cancer-biology",
    "cell-biology",
    "clinical-trials",
    "developmental-biology",
    "ecology",
    "epidemiology",
    "evolutionary-biology",
    "genetics",
    "genomics",
    "immunology",
    "microbiology",
    "molecular-biology",
    "neuroscience",
    "paleontology",
    "pathology",
    "pharmacology-and-toxicology",
    "physiology",
    "plant-biology",
    "scientific-communication-and-education",
    "synthetic-biology",
    "systems-biology",
    "zoology"
  ]
}
    """
  )

  counts = api.add_endpoint("Total entities", "/data/stats", "Basic information about how many papers and authors are indexed by Rxivist.")
  counts.add_example(
    "", "", "/data/stats",
    """{
  "papers_indexed": 34409,
  "authors_indexed": 145540,
  "missing_abstract": 0,
  "missing_date": 3539,
  "outdated_count": {
    "biophysics": 66,
    "cell-biology": 134,
    "developmental-biology": 356,
    "ecology": 3,
    "epidemiology": 1,
    "evolutionary-biology": 87,
    "genetics": 1250,
    "genomics": 292,
    "immunology": 93,
    "microbiology": 407,
    "molecular-biology": 212,
    "neuroscience": 391,
    "pharmacology-and-toxicology": 57,
    "physiology": 56,
    "plant-biology": 68,
    "scientific-communication-and-education": 51
  }
}
    """
  )

  distributions = api.add_endpoint("Site-wide metric distributions", "/data/distributions/<entity>/<metric>", "Histogram-style binned data summarizing how many papers or authors have a given metric within the range of each bin. For example, the paper downloads distribution might say that there are 15 papers with  between 0 and 9 downloads, 35 papers with between 10 and 19 downloads, 70 papers with between 20 and 29 downloads, and so on. ALSO provides averages for the specified metric.")
  entity = distributions.add_argument("path", "entity", "Which object should be used to group the metric totals.", "papers")
  entity.add_values(["paper", "author"])

  metric = distributions.add_argument("path", "metric", "Which metric to evaluate. Not currently available for Twitter data.", "downloads")
  metric.add_values(["downloads"])

  distributions.add_example(
    "Paper download distribution",
    "",
    "/data/distributions/paper/downloads",
    """{
  "averages": {
    "mean": 480,
    "median": 253
  },
  "histogram": [
    {
      "bucket_min": 0,
      "count": 4
    },
    {
      "bucket_min": 2,
      "count": 21
    },
    {
      "bucket_min": 4,
      "count": 92
    },
    {
      "bucket_min": 8,
      "count": 128
    },
    {
      "bucket_min": 16,
      "count": 272
    },
    {
      "bucket_min": 32,
      "count": 457
    }
  ]
}
    """
  )

  return api