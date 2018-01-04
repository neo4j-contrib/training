from base64 import b64encode
import json
import requests
import sys
import os

'''
Get page content
'''
def get_page_content(filename):
  file = open('cypher/html/%s' % filename)
  return file.read()

'''
Update wordpress page
'''
def update_wordpress_page(pageId, content):
    url = 'https://neo4j.com/wp-json/wp/v2/pages/%d' % (pageId)
    auth = b64encode('{}:{}'.format(os.getenv('PUBLISH_DOCS_USERNAME'), os.getenv('PUBLISH_DOCS_PASSWORD')))
    headers = {
        'Accept': 'application/json',
        'Authorization': 'Basic {}'.format(auth),
    }

    r = requests.get(url, headers=headers)
    response = json.loads(r.content)

    # build response for update
    response['content'] = content
    headers['Content-Type'] = 'application/json'
    print url
    pr = requests.post(url, headers=headers, data=json.dumps(response))
     
    return pr.content

if 'PUBLISH_DOCS_USERNAME' in os.environ and 'PUBLISH_DOCS_PASSWORD' in os.environ:
  pageContent = update_wordpress_page(64597, get_page_content('part1.html'))
  pageContent = update_wordpress_page(64608, get_page_content('part2.html'))
  pageContent = update_wordpress_page(64611, get_page_content('part3.html'))
  pageContent = update_wordpress_page(64614, get_page_content('part4.html'))
else:
  print "Environment varisbles for PUBLISH_DOCS_USERNAME and PUBLISH_DOCS_PASSWORD must be set"
  sys.exit()
