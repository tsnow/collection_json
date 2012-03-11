collection = new Collection 'api.spider-cows.com'

console.log collection.response


{"collection" :
  {
    "version" :"1.0",
    "href" :"http://api.spider-cows.com/",

    "links" :[ {"rel" :"boss_spider", "href" :"http://example.com/spider_cows/tom"}],

    "items" :
    [
      {"data" :
       [{"name" :"legs", "value" :7},
        {"name" :"eyes", "value" :8},
        {"name" :"udders", "value" :"blue"}
       ]
      },

      {"data" :
       [{"name" :"legs",  "value" :6},
        {"name" :"udders", "value" :"red"}
       ]
      }
    ]
  }
}


console.log collection.links
[{"rel" :"boss_spider", "href" :"http://example.com/spider_cows/tom"}]


console.log collection.links
