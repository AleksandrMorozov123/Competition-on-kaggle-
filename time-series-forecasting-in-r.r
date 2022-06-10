{
 "cells": [
  {
   "cell_type": "code",
   "execution_count": 1,
   "id": "97bce2bb",
   "metadata": {
    "_execution_state": "idle",
    "_uuid": "051d70d956493feee0c6d64651c6a088724dca2a",
    "execution": {
     "iopub.execute_input": "2022-06-10T11:30:41.514038Z",
     "iopub.status.busy": "2022-06-10T11:30:41.511996Z",
     "iopub.status.idle": "2022-06-10T11:30:42.883095Z",
     "shell.execute_reply": "2022-06-10T11:30:42.881150Z"
    },
    "papermill": {
     "duration": 1.381012,
     "end_time": "2022-06-10T11:30:42.886158",
     "exception": false,
     "start_time": "2022-06-10T11:30:41.505146",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stderr",
     "output_type": "stream",
     "text": [
      "── \u001b[1mAttaching packages\u001b[22m ─────────────────────────────────────── tidyverse 1.3.1 ──\n",
      "\n",
      "\u001b[32m✔\u001b[39m \u001b[34mggplot2\u001b[39m 3.3.6     \u001b[32m✔\u001b[39m \u001b[34mpurrr  \u001b[39m 0.3.4\n",
      "\u001b[32m✔\u001b[39m \u001b[34mtibble \u001b[39m 3.1.7     \u001b[32m✔\u001b[39m \u001b[34mdplyr  \u001b[39m 1.0.9\n",
      "\u001b[32m✔\u001b[39m \u001b[34mtidyr  \u001b[39m 1.2.0     \u001b[32m✔\u001b[39m \u001b[34mstringr\u001b[39m 1.4.0\n",
      "\u001b[32m✔\u001b[39m \u001b[34mreadr  \u001b[39m 2.1.2     \u001b[32m✔\u001b[39m \u001b[34mforcats\u001b[39m 0.5.1\n",
      "\n",
      "── \u001b[1mConflicts\u001b[22m ────────────────────────────────────────── tidyverse_conflicts() ──\n",
      "\u001b[31m✖\u001b[39m \u001b[34mdplyr\u001b[39m::\u001b[32mfilter()\u001b[39m masks \u001b[34mstats\u001b[39m::filter()\n",
      "\u001b[31m✖\u001b[39m \u001b[34mdplyr\u001b[39m::\u001b[32mlag()\u001b[39m    masks \u001b[34mstats\u001b[39m::lag()\n",
      "\n"
     ]
    },
    {
     "data": {
      "text/html": [
       "'store-sales-time-series-forecasting'"
      ],
      "text/latex": [
       "'store-sales-time-series-forecasting'"
      ],
      "text/markdown": [
       "'store-sales-time-series-forecasting'"
      ],
      "text/plain": [
       "[1] \"store-sales-time-series-forecasting\""
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "# This R environment comes with many helpful analytics packages installed\n",
    "# It is defined by the kaggle/rstats Docker image: https://github.com/kaggle/docker-rstats\n",
    "# For example, here's a helpful package to load\n",
    "\n",
    "library(tidyverse) # metapackage of all tidyverse packages\n",
    "\n",
    "# Input data files are available in the read-only \"../input/\" directory\n",
    "# For example, running this (by clicking run or pressing Shift+Enter) will list all files under the input directory\n",
    "\n",
    "list.files(path = \"../input\")\n",
    "\n",
    "# You can write up to 20GB to the current directory (/kaggle/working/) that gets preserved as output when you create a version using \"Save & Run All\" \n",
    "# You can also write temporary files to /kaggle/temp/, but they won't be saved outside of the current session"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "d3cead4a",
   "metadata": {
    "papermill": {
     "duration": 0.004293,
     "end_time": "2022-06-10T11:30:42.896747",
     "exception": false,
     "start_time": "2022-06-10T11:30:42.892454",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "**Loading and review all datasets**"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 2,
   "id": "5824d0c3",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-06-10T11:30:42.939831Z",
     "iopub.status.busy": "2022-06-10T11:30:42.906870Z",
     "iopub.status.idle": "2022-06-10T11:30:42.981051Z",
     "shell.execute_reply": "2022-06-10T11:30:42.978552Z"
    },
    "papermill": {
     "duration": 0.08321,
     "end_time": "2022-06-10T11:30:42.984078",
     "exception": false,
     "start_time": "2022-06-10T11:30:42.900868",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "'data.frame':\t350 obs. of  6 variables:\n",
      " $ date       : chr  \"2012-03-02\" \"2012-04-01\" \"2012-04-12\" \"2012-04-14\" ...\n",
      " $ type       : chr  \"Holiday\" \"Holiday\" \"Holiday\" \"Holiday\" ...\n",
      " $ locale     : chr  \"Local\" \"Regional\" \"Local\" \"Local\" ...\n",
      " $ locale_name: chr  \"Manta\" \"Cotopaxi\" \"Cuenca\" \"Libertad\" ...\n",
      " $ description: chr  \"Fundacion de Manta\" \"Provincializacion de Cotopaxi\" \"Fundacion de Cuenca\" \"Cantonizacion de Libertad\" ...\n",
      " $ transferred: chr  \"False\" \"False\" \"False\" \"False\" ...\n"
     ]
    }
   ],
   "source": [
    "data_holiday = read.csv ('../input/store-sales-time-series-forecasting/holidays_events.csv') # the symbol <- inconvenient to use\n",
    "str (data_holiday)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 3,
   "id": "33c1a870",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-06-10T11:30:42.996454Z",
     "iopub.status.busy": "2022-06-10T11:30:42.994928Z",
     "iopub.status.idle": "2022-06-10T11:30:43.027371Z",
     "shell.execute_reply": "2022-06-10T11:30:43.025115Z"
    },
    "papermill": {
     "duration": 0.041873,
     "end_time": "2022-06-10T11:30:43.030663",
     "exception": false,
     "start_time": "2022-06-10T11:30:42.988790",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "'data.frame':\t1218 obs. of  2 variables:\n",
      " $ date      : chr  \"2013-01-01\" \"2013-01-02\" \"2013-01-03\" \"2013-01-04\" ...\n",
      " $ dcoilwtico: num  NA 93.1 93 93.1 93.2 ...\n"
     ]
    }
   ],
   "source": [
    "data_oil = read.csv ('../input/store-sales-time-series-forecasting/oil.csv')\n",
    "str (data_oil)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 4,
   "id": "696be40f",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-06-10T11:30:43.043640Z",
     "iopub.status.busy": "2022-06-10T11:30:43.042134Z",
     "iopub.status.idle": "2022-06-10T11:30:43.069618Z",
     "shell.execute_reply": "2022-06-10T11:30:43.067625Z"
    },
    "papermill": {
     "duration": 0.036725,
     "end_time": "2022-06-10T11:30:43.072524",
     "exception": false,
     "start_time": "2022-06-10T11:30:43.035799",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "'data.frame':\t54 obs. of  5 variables:\n",
      " $ store_nbr: int  1 2 3 4 5 6 7 8 9 10 ...\n",
      " $ city     : chr  \"Quito\" \"Quito\" \"Quito\" \"Quito\" ...\n",
      " $ state    : chr  \"Pichincha\" \"Pichincha\" \"Pichincha\" \"Pichincha\" ...\n",
      " $ type     : chr  \"D\" \"D\" \"D\" \"D\" ...\n",
      " $ cluster  : int  13 13 8 9 4 13 8 8 6 15 ...\n"
     ]
    }
   ],
   "source": [
    "data_stores = read.csv ('../input/store-sales-time-series-forecasting/stores.csv')\n",
    "str (data_stores)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 5,
   "id": "8a3f79f3",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-06-10T11:30:43.085726Z",
     "iopub.status.busy": "2022-06-10T11:30:43.084186Z",
     "iopub.status.idle": "2022-06-10T11:30:43.195991Z",
     "shell.execute_reply": "2022-06-10T11:30:43.193937Z"
    },
    "papermill": {
     "duration": 0.120605,
     "end_time": "2022-06-10T11:30:43.198524",
     "exception": false,
     "start_time": "2022-06-10T11:30:43.077919",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "'data.frame':\t83488 obs. of  3 variables:\n",
      " $ date        : chr  \"2013-01-01\" \"2013-01-02\" \"2013-01-02\" \"2013-01-02\" ...\n",
      " $ store_nbr   : int  25 1 2 3 4 5 6 7 8 9 ...\n",
      " $ transactions: int  770 2111 2358 3487 1922 1903 2143 1874 3250 2940 ...\n"
     ]
    }
   ],
   "source": [
    "data_transactions = read.csv ('../input/store-sales-time-series-forecasting/transactions.csv')\n",
    "str (data_transactions)"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "ade30c4f",
   "metadata": {
    "papermill": {
     "duration": 0.004807,
     "end_time": "2022-06-10T11:30:43.208509",
     "exception": false,
     "start_time": "2022-06-10T11:30:43.203702",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "**Clean the data**"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 6,
   "id": "8c394d1f",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-06-10T11:30:43.221508Z",
     "iopub.status.busy": "2022-06-10T11:30:43.219962Z",
     "iopub.status.idle": "2022-06-10T11:30:43.375477Z",
     "shell.execute_reply": "2022-06-10T11:30:43.373212Z"
    },
    "papermill": {
     "duration": 0.165349,
     "end_time": "2022-06-10T11:30:43.378558",
     "exception": false,
     "start_time": "2022-06-10T11:30:43.213209",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stderr",
     "output_type": "stream",
     "text": [
      "\n",
      "Attaching package: ‘janitor’\n",
      "\n",
      "\n",
      "The following objects are masked from ‘package:stats’:\n",
      "\n",
      "    chisq.test, fisher.test\n",
      "\n",
      "\n"
     ]
    },
    {
     "data": {
      "text/html": [
       "<style>\n",
       ".list-inline {list-style: none; margin:0; padding: 0}\n",
       ".list-inline>li {display: inline-block}\n",
       ".list-inline>li:not(:last-child)::after {content: \"\\00b7\"; padding: 0 .5ex}\n",
       "</style>\n",
       "<ol class=list-inline><li>'date'</li><li>'type'</li><li>'locale'</li><li>'locale_name'</li><li>'description'</li><li>'transferred'</li></ol>\n"
      ],
      "text/latex": [
       "\\begin{enumerate*}\n",
       "\\item 'date'\n",
       "\\item 'type'\n",
       "\\item 'locale'\n",
       "\\item 'locale\\_name'\n",
       "\\item 'description'\n",
       "\\item 'transferred'\n",
       "\\end{enumerate*}\n"
      ],
      "text/markdown": [
       "1. 'date'\n",
       "2. 'type'\n",
       "3. 'locale'\n",
       "4. 'locale_name'\n",
       "5. 'description'\n",
       "6. 'transferred'\n",
       "\n",
       "\n"
      ],
      "text/plain": [
       "[1] \"date\"        \"type\"        \"locale\"      \"locale_name\" \"description\"\n",
       "[6] \"transferred\""
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "# import required libraries\n",
    "library (stats)\n",
    "library (base)\n",
    "library(janitor)\n",
    "\n",
    "clean = clean_names (data_holiday)\n",
    "colnames (clean)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 7,
   "id": "3fe37836",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-06-10T11:30:43.391848Z",
     "iopub.status.busy": "2022-06-10T11:30:43.390312Z",
     "iopub.status.idle": "2022-06-10T11:30:43.500377Z",
     "shell.execute_reply": "2022-06-10T11:30:43.498672Z"
    },
    "papermill": {
     "duration": 0.119453,
     "end_time": "2022-06-10T11:30:43.502909",
     "exception": false,
     "start_time": "2022-06-10T11:30:43.383456",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A tabyl: 6 × 4</caption>\n",
       "<thead>\n",
       "\t<tr><th scope=col>type</th><th scope=col>Local</th><th scope=col>National</th><th scope=col>Regional</th></tr>\n",
       "\t<tr><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><td>Additional</td><td> 11</td><td>40</td><td> 0</td></tr>\n",
       "\t<tr><td>Bridge    </td><td>  0</td><td> 5</td><td> 0</td></tr>\n",
       "\t<tr><td>Event     </td><td>  0</td><td>56</td><td> 0</td></tr>\n",
       "\t<tr><td>Holiday   </td><td>137</td><td>60</td><td>24</td></tr>\n",
       "\t<tr><td>Transfer  </td><td>  4</td><td> 8</td><td> 0</td></tr>\n",
       "\t<tr><td>Work Day  </td><td>  0</td><td> 5</td><td> 0</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A tabyl: 6 × 4\n",
       "\\begin{tabular}{llll}\n",
       " type & Local & National & Regional\\\\\n",
       " <chr> & <dbl> & <dbl> & <dbl>\\\\\n",
       "\\hline\n",
       "\t Additional &  11 & 40 &  0\\\\\n",
       "\t Bridge     &   0 &  5 &  0\\\\\n",
       "\t Event      &   0 & 56 &  0\\\\\n",
       "\t Holiday    & 137 & 60 & 24\\\\\n",
       "\t Transfer   &   4 &  8 &  0\\\\\n",
       "\t Work Day   &   0 &  5 &  0\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A tabyl: 6 × 4\n",
       "\n",
       "| type &lt;chr&gt; | Local &lt;dbl&gt; | National &lt;dbl&gt; | Regional &lt;dbl&gt; |\n",
       "|---|---|---|---|\n",
       "| Additional |  11 | 40 |  0 |\n",
       "| Bridge     |   0 |  5 |  0 |\n",
       "| Event      |   0 | 56 |  0 |\n",
       "| Holiday    | 137 | 60 | 24 |\n",
       "| Transfer   |   4 |  8 |  0 |\n",
       "| Work Day   |   0 |  5 |  0 |\n",
       "\n"
      ],
      "text/plain": [
       "  type       Local National Regional\n",
       "1 Additional  11   40        0      \n",
       "2 Bridge       0    5        0      \n",
       "3 Event        0   56        0      \n",
       "4 Holiday    137   60       24      \n",
       "5 Transfer     4    8        0      \n",
       "6 Work Day     0    5        0      "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "tabyl (clean, type, locale)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 8,
   "id": "59b209d9",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-06-10T11:30:43.516990Z",
     "iopub.status.busy": "2022-06-10T11:30:43.515354Z",
     "iopub.status.idle": "2022-06-10T11:30:43.561792Z",
     "shell.execute_reply": "2022-06-10T11:30:43.560036Z"
    },
    "papermill": {
     "duration": 0.055775,
     "end_time": "2022-06-10T11:30:43.564161",
     "exception": false,
     "start_time": "2022-06-10T11:30:43.508386",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A tabyl: 6 × 4</caption>\n",
       "<thead>\n",
       "\t<tr><th scope=col>type</th><th scope=col>Local</th><th scope=col>National</th><th scope=col>Regional</th></tr>\n",
       "\t<tr><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><td>Additional</td><td>1100.00% </td><td>4000.00%</td><td>0.00%   </td></tr>\n",
       "\t<tr><td>Bridge    </td><td>0.00%    </td><td>500.00% </td><td>0.00%   </td></tr>\n",
       "\t<tr><td>Event     </td><td>0.00%    </td><td>5600.00%</td><td>0.00%   </td></tr>\n",
       "\t<tr><td>Holiday   </td><td>13700.00%</td><td>6000.00%</td><td>2400.00%</td></tr>\n",
       "\t<tr><td>Transfer  </td><td>400.00%  </td><td>800.00% </td><td>0.00%   </td></tr>\n",
       "\t<tr><td>Work Day  </td><td>0.00%    </td><td>500.00% </td><td>0.00%   </td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A tabyl: 6 × 4\n",
       "\\begin{tabular}{llll}\n",
       " type & Local & National & Regional\\\\\n",
       " <chr> & <chr> & <chr> & <chr>\\\\\n",
       "\\hline\n",
       "\t Additional & 1100.00\\%  & 4000.00\\% & 0.00\\%   \\\\\n",
       "\t Bridge     & 0.00\\%     & 500.00\\%  & 0.00\\%   \\\\\n",
       "\t Event      & 0.00\\%     & 5600.00\\% & 0.00\\%   \\\\\n",
       "\t Holiday    & 13700.00\\% & 6000.00\\% & 2400.00\\%\\\\\n",
       "\t Transfer   & 400.00\\%   & 800.00\\%  & 0.00\\%   \\\\\n",
       "\t Work Day   & 0.00\\%     & 500.00\\%  & 0.00\\%   \\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A tabyl: 6 × 4\n",
       "\n",
       "| type &lt;chr&gt; | Local &lt;chr&gt; | National &lt;chr&gt; | Regional &lt;chr&gt; |\n",
       "|---|---|---|---|\n",
       "| Additional | 1100.00%  | 4000.00% | 0.00%    |\n",
       "| Bridge     | 0.00%     | 500.00%  | 0.00%    |\n",
       "| Event      | 0.00%     | 5600.00% | 0.00%    |\n",
       "| Holiday    | 13700.00% | 6000.00% | 2400.00% |\n",
       "| Transfer   | 400.00%   | 800.00%  | 0.00%    |\n",
       "| Work Day   | 0.00%     | 500.00%  | 0.00%    |\n",
       "\n"
      ],
      "text/plain": [
       "  type       Local     National Regional\n",
       "1 Additional 1100.00%  4000.00% 0.00%   \n",
       "2 Bridge     0.00%     500.00%  0.00%   \n",
       "3 Event      0.00%     5600.00% 0.00%   \n",
       "4 Holiday    13700.00% 6000.00% 2400.00%\n",
       "5 Transfer   400.00%   800.00%  0.00%   \n",
       "6 Work Day   0.00%     500.00%  0.00%   "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "clean %>% tabyl (type, locale) %>% adorn_pct_formatting (digits = 2, affix_sign = TRUE)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 9,
   "id": "cc505f9d",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-06-10T11:30:43.578178Z",
     "iopub.status.busy": "2022-06-10T11:30:43.576682Z",
     "iopub.status.idle": "2022-06-10T11:30:43.628710Z",
     "shell.execute_reply": "2022-06-10T11:30:43.626459Z"
    },
    "papermill": {
     "duration": 0.061939,
     "end_time": "2022-06-10T11:30:43.631493",
     "exception": false,
     "start_time": "2022-06-10T11:30:43.569554",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A tabyl: 7 × 4</caption>\n",
       "<thead>\n",
       "\t<tr><th></th><th scope=col>type</th><th scope=col>Local</th><th scope=col>National</th><th scope=col>Regional</th></tr>\n",
       "\t<tr><th></th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><th scope=row>1</th><td>Additional</td><td> 11</td><td> 40</td><td> 0</td></tr>\n",
       "\t<tr><th scope=row>2</th><td>Bridge    </td><td>  0</td><td>  5</td><td> 0</td></tr>\n",
       "\t<tr><th scope=row>3</th><td>Event     </td><td>  0</td><td> 56</td><td> 0</td></tr>\n",
       "\t<tr><th scope=row>4</th><td>Holiday   </td><td>137</td><td> 60</td><td>24</td></tr>\n",
       "\t<tr><th scope=row>5</th><td>Transfer  </td><td>  4</td><td>  8</td><td> 0</td></tr>\n",
       "\t<tr><th scope=row>6</th><td>Work Day  </td><td>  0</td><td>  5</td><td> 0</td></tr>\n",
       "\t<tr><th scope=row>7</th><td>Total     </td><td>152</td><td>174</td><td>24</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A tabyl: 7 × 4\n",
       "\\begin{tabular}{r|llll}\n",
       "  & type & Local & National & Regional\\\\\n",
       "  & <chr> & <dbl> & <dbl> & <dbl>\\\\\n",
       "\\hline\n",
       "\t1 & Additional &  11 &  40 &  0\\\\\n",
       "\t2 & Bridge     &   0 &   5 &  0\\\\\n",
       "\t3 & Event      &   0 &  56 &  0\\\\\n",
       "\t4 & Holiday    & 137 &  60 & 24\\\\\n",
       "\t5 & Transfer   &   4 &   8 &  0\\\\\n",
       "\t6 & Work Day   &   0 &   5 &  0\\\\\n",
       "\t7 & Total      & 152 & 174 & 24\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A tabyl: 7 × 4\n",
       "\n",
       "| <!--/--> | type &lt;chr&gt; | Local &lt;dbl&gt; | National &lt;dbl&gt; | Regional &lt;dbl&gt; |\n",
       "|---|---|---|---|---|\n",
       "| 1 | Additional |  11 |  40 |  0 |\n",
       "| 2 | Bridge     |   0 |   5 |  0 |\n",
       "| 3 | Event      |   0 |  56 |  0 |\n",
       "| 4 | Holiday    | 137 |  60 | 24 |\n",
       "| 5 | Transfer   |   4 |   8 |  0 |\n",
       "| 6 | Work Day   |   0 |   5 |  0 |\n",
       "| 7 | Total      | 152 | 174 | 24 |\n",
       "\n"
      ],
      "text/plain": [
       "  type       Local National Regional\n",
       "1 Additional  11    40       0      \n",
       "2 Bridge       0     5       0      \n",
       "3 Event        0    56       0      \n",
       "4 Holiday    137    60      24      \n",
       "5 Transfer     4     8       0      \n",
       "6 Work Day     0     5       0      \n",
       "7 Total      152   174      24      "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "clean %>% tabyl (type, locale) %>% adorn_totals ()"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 10,
   "id": "fdf589f9",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-06-10T11:30:43.646373Z",
     "iopub.status.busy": "2022-06-10T11:30:43.644810Z",
     "iopub.status.idle": "2022-06-10T11:30:43.713158Z",
     "shell.execute_reply": "2022-06-10T11:30:43.711400Z"
    },
    "papermill": {
     "duration": 0.078219,
     "end_time": "2022-06-10T11:30:43.715570",
     "exception": false,
     "start_time": "2022-06-10T11:30:43.637351",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A tabyl: 6 × 5</caption>\n",
       "<thead>\n",
       "\t<tr><th scope=col>type</th><th scope=col>Local</th><th scope=col>National</th><th scope=col>Regional</th><th scope=col>Total</th></tr>\n",
       "\t<tr><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><td>Additional</td><td> 11</td><td>40</td><td> 0</td><td> 51</td></tr>\n",
       "\t<tr><td>Bridge    </td><td>  0</td><td> 5</td><td> 0</td><td>  5</td></tr>\n",
       "\t<tr><td>Event     </td><td>  0</td><td>56</td><td> 0</td><td> 56</td></tr>\n",
       "\t<tr><td>Holiday   </td><td>137</td><td>60</td><td>24</td><td>221</td></tr>\n",
       "\t<tr><td>Transfer  </td><td>  4</td><td> 8</td><td> 0</td><td> 12</td></tr>\n",
       "\t<tr><td>Work Day  </td><td>  0</td><td> 5</td><td> 0</td><td>  5</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A tabyl: 6 × 5\n",
       "\\begin{tabular}{lllll}\n",
       " type & Local & National & Regional & Total\\\\\n",
       " <chr> & <dbl> & <dbl> & <dbl> & <dbl>\\\\\n",
       "\\hline\n",
       "\t Additional &  11 & 40 &  0 &  51\\\\\n",
       "\t Bridge     &   0 &  5 &  0 &   5\\\\\n",
       "\t Event      &   0 & 56 &  0 &  56\\\\\n",
       "\t Holiday    & 137 & 60 & 24 & 221\\\\\n",
       "\t Transfer   &   4 &  8 &  0 &  12\\\\\n",
       "\t Work Day   &   0 &  5 &  0 &   5\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A tabyl: 6 × 5\n",
       "\n",
       "| type &lt;chr&gt; | Local &lt;dbl&gt; | National &lt;dbl&gt; | Regional &lt;dbl&gt; | Total &lt;dbl&gt; |\n",
       "|---|---|---|---|---|\n",
       "| Additional |  11 | 40 |  0 |  51 |\n",
       "| Bridge     |   0 |  5 |  0 |   5 |\n",
       "| Event      |   0 | 56 |  0 |  56 |\n",
       "| Holiday    | 137 | 60 | 24 | 221 |\n",
       "| Transfer   |   4 |  8 |  0 |  12 |\n",
       "| Work Day   |   0 |  5 |  0 |   5 |\n",
       "\n"
      ],
      "text/plain": [
       "  type       Local National Regional Total\n",
       "1 Additional  11   40        0        51  \n",
       "2 Bridge       0    5        0         5  \n",
       "3 Event        0   56        0        56  \n",
       "4 Holiday    137   60       24       221  \n",
       "5 Transfer     4    8        0        12  \n",
       "6 Work Day     0    5        0         5  "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "clean %>% tabyl (type, locale) %>% adorn_totals (where = \"col\")"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 11,
   "id": "21f3efd5",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-06-10T11:30:43.731028Z",
     "iopub.status.busy": "2022-06-10T11:30:43.729416Z",
     "iopub.status.idle": "2022-06-10T11:30:43.792096Z",
     "shell.execute_reply": "2022-06-10T11:30:43.789740Z"
    },
    "papermill": {
     "duration": 0.073678,
     "end_time": "2022-06-10T11:30:43.795079",
     "exception": false,
     "start_time": "2022-06-10T11:30:43.721401",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A tabyl: 7 × 5</caption>\n",
       "<thead>\n",
       "\t<tr><th></th><th scope=col>type</th><th scope=col>Local</th><th scope=col>National</th><th scope=col>Regional</th><th scope=col>Total</th></tr>\n",
       "\t<tr><th></th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><th scope=row>1</th><td>Additional</td><td> 11</td><td> 40</td><td> 0</td><td> 51</td></tr>\n",
       "\t<tr><th scope=row>2</th><td>Bridge    </td><td>  0</td><td>  5</td><td> 0</td><td>  5</td></tr>\n",
       "\t<tr><th scope=row>3</th><td>Event     </td><td>  0</td><td> 56</td><td> 0</td><td> 56</td></tr>\n",
       "\t<tr><th scope=row>4</th><td>Holiday   </td><td>137</td><td> 60</td><td>24</td><td>221</td></tr>\n",
       "\t<tr><th scope=row>5</th><td>Transfer  </td><td>  4</td><td>  8</td><td> 0</td><td> 12</td></tr>\n",
       "\t<tr><th scope=row>6</th><td>Work Day  </td><td>  0</td><td>  5</td><td> 0</td><td>  5</td></tr>\n",
       "\t<tr><th scope=row>7</th><td>Total     </td><td>152</td><td>174</td><td>24</td><td>350</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A tabyl: 7 × 5\n",
       "\\begin{tabular}{r|lllll}\n",
       "  & type & Local & National & Regional & Total\\\\\n",
       "  & <chr> & <dbl> & <dbl> & <dbl> & <dbl>\\\\\n",
       "\\hline\n",
       "\t1 & Additional &  11 &  40 &  0 &  51\\\\\n",
       "\t2 & Bridge     &   0 &   5 &  0 &   5\\\\\n",
       "\t3 & Event      &   0 &  56 &  0 &  56\\\\\n",
       "\t4 & Holiday    & 137 &  60 & 24 & 221\\\\\n",
       "\t5 & Transfer   &   4 &   8 &  0 &  12\\\\\n",
       "\t6 & Work Day   &   0 &   5 &  0 &   5\\\\\n",
       "\t7 & Total      & 152 & 174 & 24 & 350\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A tabyl: 7 × 5\n",
       "\n",
       "| <!--/--> | type &lt;chr&gt; | Local &lt;dbl&gt; | National &lt;dbl&gt; | Regional &lt;dbl&gt; | Total &lt;dbl&gt; |\n",
       "|---|---|---|---|---|---|\n",
       "| 1 | Additional |  11 |  40 |  0 |  51 |\n",
       "| 2 | Bridge     |   0 |   5 |  0 |   5 |\n",
       "| 3 | Event      |   0 |  56 |  0 |  56 |\n",
       "| 4 | Holiday    | 137 |  60 | 24 | 221 |\n",
       "| 5 | Transfer   |   4 |   8 |  0 |  12 |\n",
       "| 6 | Work Day   |   0 |   5 |  0 |   5 |\n",
       "| 7 | Total      | 152 | 174 | 24 | 350 |\n",
       "\n"
      ],
      "text/plain": [
       "  type       Local National Regional Total\n",
       "1 Additional  11    40       0        51  \n",
       "2 Bridge       0     5       0         5  \n",
       "3 Event        0    56       0        56  \n",
       "4 Holiday    137    60      24       221  \n",
       "5 Transfer     4     8       0        12  \n",
       "6 Work Day     0     5       0         5  \n",
       "7 Total      152   174      24       350  "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "clean %>% tabyl (type, locale) %>% adorn_totals (where = c (\"row\", \"col\"))"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 12,
   "id": "4dad3178",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-06-10T11:30:43.811396Z",
     "iopub.status.busy": "2022-06-10T11:30:43.809773Z",
     "iopub.status.idle": "2022-06-10T11:30:43.943344Z",
     "shell.execute_reply": "2022-06-10T11:30:43.941107Z"
    },
    "papermill": {
     "duration": 0.144661,
     "end_time": "2022-06-10T11:30:43.946194",
     "exception": false,
     "start_time": "2022-06-10T11:30:43.801533",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A tabyl: 7 × 4</caption>\n",
       "<thead>\n",
       "\t<tr><th></th><th scope=col>type</th><th scope=col>Local</th><th scope=col>National</th><th scope=col>Regional</th></tr>\n",
       "\t<tr><th></th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><th scope=row>1</th><td>Additional</td><td>21.6%  (11)</td><td>78.4%  (40) </td><td>0.0%  (0) </td></tr>\n",
       "\t<tr><th scope=row>2</th><td>Bridge    </td><td>0.0%   (0) </td><td>100.0%   (5)</td><td>0.0%  (0) </td></tr>\n",
       "\t<tr><th scope=row>3</th><td>Event     </td><td>0.0%   (0) </td><td>100.0%  (56)</td><td>0.0%  (0) </td></tr>\n",
       "\t<tr><th scope=row>4</th><td>Holiday   </td><td>62.0% (137)</td><td>27.1%  (60) </td><td>10.9% (24)</td></tr>\n",
       "\t<tr><th scope=row>5</th><td>Transfer  </td><td>33.3%   (4)</td><td>66.7%   (8) </td><td>0.0%  (0) </td></tr>\n",
       "\t<tr><th scope=row>6</th><td>Work Day  </td><td>0.0%   (0) </td><td>100.0%   (5)</td><td>0.0%  (0) </td></tr>\n",
       "\t<tr><th scope=row>7</th><td>Total     </td><td>43.4% (152)</td><td>49.7% (174) </td><td>6.9% (24) </td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A tabyl: 7 × 4\n",
       "\\begin{tabular}{r|llll}\n",
       "  & type & Local & National & Regional\\\\\n",
       "  & <chr> & <chr> & <chr> & <chr>\\\\\n",
       "\\hline\n",
       "\t1 & Additional & 21.6\\%  (11) & 78.4\\%  (40)  & 0.0\\%  (0) \\\\\n",
       "\t2 & Bridge     & 0.0\\%   (0)  & 100.0\\%   (5) & 0.0\\%  (0) \\\\\n",
       "\t3 & Event      & 0.0\\%   (0)  & 100.0\\%  (56) & 0.0\\%  (0) \\\\\n",
       "\t4 & Holiday    & 62.0\\% (137) & 27.1\\%  (60)  & 10.9\\% (24)\\\\\n",
       "\t5 & Transfer   & 33.3\\%   (4) & 66.7\\%   (8)  & 0.0\\%  (0) \\\\\n",
       "\t6 & Work Day   & 0.0\\%   (0)  & 100.0\\%   (5) & 0.0\\%  (0) \\\\\n",
       "\t7 & Total      & 43.4\\% (152) & 49.7\\% (174)  & 6.9\\% (24) \\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A tabyl: 7 × 4\n",
       "\n",
       "| <!--/--> | type &lt;chr&gt; | Local &lt;chr&gt; | National &lt;chr&gt; | Regional &lt;chr&gt; |\n",
       "|---|---|---|---|---|\n",
       "| 1 | Additional | 21.6%  (11) | 78.4%  (40)  | 0.0%  (0)  |\n",
       "| 2 | Bridge     | 0.0%   (0)  | 100.0%   (5) | 0.0%  (0)  |\n",
       "| 3 | Event      | 0.0%   (0)  | 100.0%  (56) | 0.0%  (0)  |\n",
       "| 4 | Holiday    | 62.0% (137) | 27.1%  (60)  | 10.9% (24) |\n",
       "| 5 | Transfer   | 33.3%   (4) | 66.7%   (8)  | 0.0%  (0)  |\n",
       "| 6 | Work Day   | 0.0%   (0)  | 100.0%   (5) | 0.0%  (0)  |\n",
       "| 7 | Total      | 43.4% (152) | 49.7% (174)  | 6.9% (24)  |\n",
       "\n"
      ],
      "text/plain": [
       "  type       Local       National     Regional  \n",
       "1 Additional 21.6%  (11) 78.4%  (40)  0.0%  (0) \n",
       "2 Bridge     0.0%   (0)  100.0%   (5) 0.0%  (0) \n",
       "3 Event      0.0%   (0)  100.0%  (56) 0.0%  (0) \n",
       "4 Holiday    62.0% (137) 27.1%  (60)  10.9% (24)\n",
       "5 Transfer   33.3%   (4) 66.7%   (8)  0.0%  (0) \n",
       "6 Work Day   0.0%   (0)  100.0%   (5) 0.0%  (0) \n",
       "7 Total      43.4% (152) 49.7% (174)  6.9% (24) "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "clean %>% tabyl (type, locale) %>% adorn_totals(\"row\") %>% adorn_percentages (\"row\") %>%\n",
    "adorn_pct_formatting () %>% adorn_ns ()"
   ]
  }
 ],
 "metadata": {
  "kernelspec": {
   "display_name": "R",
   "language": "R",
   "name": "ir"
  },
  "language_info": {
   "codemirror_mode": "r",
   "file_extension": ".r",
   "mimetype": "text/x-r-source",
   "name": "R",
   "pygments_lexer": "r",
   "version": "4.0.5"
  },
  "papermill": {
   "default_parameters": {},
   "duration": 6.588606,
   "end_time": "2022-06-10T11:30:44.080477",
   "environment_variables": {},
   "exception": null,
   "input_path": "__notebook__.ipynb",
   "output_path": "__notebook__.ipynb",
   "parameters": {},
   "start_time": "2022-06-10T11:30:37.491871",
   "version": "2.3.4"
  }
 },
 "nbformat": 4,
 "nbformat_minor": 5
}
