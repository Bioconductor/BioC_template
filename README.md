
# Bioconductor conference template website

This repository contains material for the Bioconductor annual conference. 
View the example at https://bioc2022.bioconductor.org/ and the corresponding
[GitHub repo](https://github.com/Bioconductor/BioC2022)

# Create a new website for an annual BiocConference

## Dependencies

Make sure [Hugo is installed](https://gohugo.io/getting-started/installing/).
Check Hugo version

```shell
hugo version
```

## Branches

- [master](https://github.com/Bioconductor/BioC_template/tree/master) branch contains a minimal set of files to create the conference website. 
- [master-full](https://github.com/Bioconductor/BioC_template/tree/master-full) contains additional files in subfolders [content/abstracts](https://github.com/Bioconductor/BioC_template/tree/master-full/content/abstracts), [content/news](https://github.com/Bioconductor/BioC_template/tree/master-full/content/news), [data/abstracts](https://github.com/Bioconductor/BioC_template/tree/master-full/data/abstracts) with additional files (mirror from the [BioC2022](https://github.com/Bioconductor/BioC2022) repository).

## Create a new repository

1. Create a new repository in https://github.com/Bioconductor using this
template.

2. Clone the new repository and switch to it. For example:

```shell
git clone git@github.com:Bioconductor/BioC_template.git
cd BioC_template/
```

3. Edit the site

- [config.toml](https://github.com/Bioconductor/BioC_template/tree/master/config.toml)
    - Adjust color style: style = "blue" (default), light-blue), green, marsala, pink, red, turquoise, violet
    - Edit "defaultKeywords", to make the site findable via Google. These keywords are used in `themes/hugo-universal-theme/layouts/partials/head.html`
- .md files in the [content](https://github.com/Bioconductor/BioC_template/tree/master/content/) folder
- .yaml files in [data/carousel](https://github.com/Bioconductor/BioC_template/tree/master/data/carousel/) (create a new hex logo, open an [issue](https://github.com/Bioconductor/BiocStickers/issues) on [BiocStickers](https://github.com/Bioconductor/BiocStickers/))
- rename [data/committee.all](https://github.com/Bioconductor/BioC_template/tree/master/data/committee.all/) folder to `committee` and adjust committee members
- add [data/speakers](https://github.com/Bioconductor/BioC_template/tree/master/data/speakers/)
- add sponsors to [data/clients](https://github.com/Bioconductor/BioC_template/tree/master/data/clients/) and [static/img/clients](https://github.com/Bioconductor/BioC_template/tree/master/static/img/clients/) (take logos from [Google Drive]())
- Edit the front page [news.html](https://github.com/Bioconductor/BioC_template/tree/master/layouts/partials/news.html)

4. Run Hugo to preview the webpage locally.

```shell
rm -rf public; hugo --verbose; hugo server --disableFastRender --verbose
```

View the results at http://localhost:1313/

5. Host your site on [Netlify](https://www.netlify.com/), 
as described [here](https://bookdown.org/yihui/blogdown/netlify.html). 
Use build command `hugo`, publish directory `public`,
and set advanced variable `HUGO_VERSION` to your `hugo version` number,
e.g., 0.105.0

6. To add an official URL/domain, e.g., bioc2023.bioconductor.org, first, contact [Lori](https://github.com/lshep) to create it. Second, login to Netlify, select the site, click "Domain settings" button, then "Add custom domain". Add the official URL when prompted and click "Verify". You'll get a message "bioconductor.org is already registered. If you registered this domain name through a different registrar, select Add subdomain to begin delegating it to Netlify." Click "Add subdomain", and the official domain will be added. Click "Check DNS configuration" and check how to update the CNAME recors. It'll take up to 24 hours before the changes will take effect.

# Adding items to the schedule table

1. Make changes in the "schedule table" spreadsheet https://docs.google.com/spreadsheets/d/1tGtGffcbCRxQFjE3ej42IcWlN4FJCsuQeZvETt9g0oA/edit#gid=0. NOTE - For the "time" column, set the format to custom "hh:mm" (IMPORTANT)
2. Run the following command in the terminal in the base directory:
```bash
Rscript --vanilla 1_create_yaml.R; bash 2_create_abstracts.sh; bash 3_create_tracks.sh
```

### Adding data for the schedule

+ Data for the abstracts and other elements for the schedule table should be located in `data/abstracts/`. This folder is populated by `1_create_yaml.R` from the "schedule table" spreadsheet.

There are three types of abstracts.

1. papers. Name format: day1_1315_longWorkshop_paper25.yaml. 
2. tracks. Name format: day1_0900_shortTalksSysEpi_track.yaml.
3. All other elements that will be added to the schedule.

Abstract file name format: day[1-3]_HHMM_type_paper/track#.yaml. 
The abstracts should all contain these fields. If any field isn't used, it should remain blank. 

```
title: "" # A string with the full title.
paper: "" # Number of paper or track. Valid options: paper# or track#. For example, paper2, track1, etc. track is only used for the short talks tracks. There is no defined track number as in the case of the papers, they should be added in order of appearance in the document.
session_type: "" # String with the type. Valid options: "Short talk", "Short talks track", "Package demo", "Workshop".
authors: "" # String with the authors separated by comma.
presenting_author: "" # Author who will present. The first author by default.
affiliation: "" # String with the affiliation.
abstract: "" # String with the abstract. Sometimes there are quotes in the text which should be escaped.
time: "" # The time in 24h format. Example: 1300 for 1 PM.
github: "" # Haven't used this field. Not sure if this has been provided.
twitter: "" # Twitter handle without the @.
youtube: "" # Link to youtube video when available.
day: "" # Valid options: day1, day2, day3.
talks: "" # This field is only for the short talk tracks. This should list the number of papers under this track. This should be a YAML array. Example: ["paper10", "paper20"]
```

+ The `content/abstracts/` directory contains the individual pages for the
abstracts. This directory could be ignored as it will be updated with
the `2_create_abstracts.sh` and `3_create_tracks.sh` bash scripts. These scripts
convert the elements in data to content pages.

======

# data

YAML files that need to be adjusted for each conference. 

## abstracts

YAML files for every event. `Workshop_paper` are processed by [content/workshops.md](content/workshops.md) and [layouts/shortcodes/workshops.html](layouts/shortcodes/workshops.html). All events are processed by [layouts/shortcodes/schedule.html](layouts/shortcodes/schedule.html).

## carousel

YAML files for the carousel panels. Processed by the main theme.

## clients

YAML files for sponsors. Processed by the main theme and [layouts/shortcodes/sponsors.html](layouts/shortcodes/sponsors.html)

## organizers

YAML files for co-chairs and committee. Processed by [content/organizers.md](content/organizers.md), [layouts/shortcodes/cochairs.html](layouts/shortcodes/cochairs.html) and [layouts/shortcodes/committee.html](layouts/shortcodes/committee.html).

## speakers

YAML files for each speaker. Processed by [layouts/partials/speakers.html](layouts/partials/speakers.html).

# Disclaimer

This template was created using the modified.
[hugo-universal-theme](https://github.com/devcows/hugo-universal-theme).
See the [demo web site](https://themes.gohugo.io/theme/hugo-universal-theme/),
the original [github repository](https://github.com/devcows/hugo-universal-theme)
and the [exampleSite files](https://github.com/devcows/hugo-universal-theme/tree/master/exampleSite).
Template by [Bootstrapious](https://bootstrapious.com/p/universal-business-e-commerce-template).
Ported to Hugo by [DevCows](https://github.com/devcows/hugo-universal-theme).
The theme is added as selected files, not as a submodule, for easier modification.