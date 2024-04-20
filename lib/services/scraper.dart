import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;

import '../util/functions.dart';

class Scraper {

  static const mm = ' 🖐🏽 🖐🏽 🖐🏽Scraper  🖐🏽';

  Future<void> handleHtml(String html) async {
    var document = parse(html);
    pp('\n\n\n');
    for (var element in document.getElementsByClassName('oe_login_form')) {
      if (element.hasChildNodes()) {
        for (var element in element.children) {
          pp('$mm nodes: ${element.nodes.length}');
        }
      }
    }
  }

  Future<String> _calculateCsrfToken() async {
    pp('\n\n$mm _calculateCsrfToken .......');

    var response = await http.get(Uri.parse('https://remotive.com/web/login?email=malengadev@gmail.com&password=Bju49Aaz@!r69UG'));
    var document = parse(response.body);
    var csrfTokenElement = document.getElementsByTagName('input')
        .firstWhere((element) => element.attributes['name'] == 'csrf_token');
    return csrfTokenElement.attributes['value']!;
  }

  Future<http.Response> sendLoginRequest( String email, String password) async {
    String csrfToken = await _calculateCsrfToken();
    pp('\n\n$mm sendLoginRequest: 🍎csrfToken: $csrfToken 🍎');
    var response = await http.post(
      Uri.parse('https://remotive.com/web/login'),
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: {
        'csrf_token': csrfToken,
        'login': email,
        'password': password,
      },
    );
    pp('$mm Remotive Login response, 🍎statusCode: ${response.statusCode} 🍎🍎Body: ${response.body}\n\n');
    return response;
  }

  static const dollar = '\$crisp';
}

 const dollar = '\$crisp';
 const myHtml = ''' 
<!DOCTYPE html>
<html lang="en-US" data-website-id="1" data-oe-company-name="Remotive SARL">

<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
    <title>Login | Remotive</title>
    <link type="image/x-icon" rel="shortcut icon" href="/remotive_website_layout/static/src/img/favicon.ico" />
    <script type="text/javascript">
        var odoo = {
                        csrf_token: "5c9855ee044632caf82a82b4d653511d4db0a4dbo",
                    };
    </script>
    <meta name="generator" content="Odoo" />
    <meta property="og:type" content="website" />
    <meta property="og:title" content="Login | Remotive" />
    <meta property="og:site_name" content="Remotive" />
    <meta property="og:url" content="https://remotive.com/web/login" />
    <meta property="og:image" content="https://remotive.com/web/image/website/1/social_default_image" />
    <meta name="twitter:card" content="summary_large_image" />
    <meta name="twitter:title" content="Login | Remotive" />
    <meta name="twitter:image" content="https://remotive.com/web/image/website/1/social_default_image" />
    <meta name="twitter:site" content="@remotiveio" />
    <link rel="alternate" hreflang="en"
        href="https://remotive.com/web/login?email=malengadev@gmail.com&amp;password=Bju49Aaz@!r69UG" />
    <script type="text/javascript">
        odoo.session_info = {
                    is_admin: false,
                    is_system: false,
                    is_frontend: true,
                    translationURL: '/website/translations',
                    is_website_user: true
                };
                
    </script>
    <link type="text/css" rel="stylesheet" href="/web/content/739819-acc1a6a/1/web.assets_common.0.css" />
    <link type="text/css" rel="stylesheet" href="/web/content/4768416-7e7a189/1/web.assets_frontend.0.css" />
    <link type="text/css" rel="stylesheet" href="/web/content/4768417-7e7a189/1/web.assets_frontend.1.css" />
    <script type="text/javascript" src="/web/content/739837-acc1a6a/1/web.assets_common.js"></script>
    <script async type="text/javascript" src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>
    <script src="https://js.stripe.com/v3"></script>
    <script type="text/javascript" src="/web/content/4768418-7e7a189/1/web.assets_frontend.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" />
    <script async src="https://www.googletagmanager.com/gtag/js?id=G-6LVX55VKHW"></script>
    <script>
        window.dataLayer = window.dataLayer || [];
                        function gtag(){dataLayer.push(arguments);}
                        gtag('js', new Date());
                        gtag('config', 'G-6LVX55VKHW');
    </script>
    <script type="text/javascript">
        window.$dollar=[];window.CRISP_WEBSITE_ID="52fbe69c-9517-4998-88a0-b10d4415b60e";(function(){d=document;s=d.createElement("script");s.src="https://client.crisp.chat/l.js";s.async=1;d.getElementsByTagName("head")[0].appendChild(s);})();
    </script>
    <script>
        $dollar.push(["on", "chat:initiated",
                            function() {
                                $dollar.push(["do", "message:show", ["picker", {
                                  "id": "user-type-id",
                                  "text": "Are you a member of [Remotive Accelerator](https://remotive.com/accelerator)?",

                                  "choices": [
                                    {
                                        "value": "yes",
                                        "label": "Yes i am!",
                                        "selected": false
                                    },

                                    {
                                        "value": "no",
                                        "label": "Nope, i am a free user.",
                                        "selected": false
                                    }
                                  ]
                                }]])
                            }
                        ])

                        let msgFingerprint = null;

                        $dollar.push(["on", "message:received", function(data) {
                          // Skip responses not being updates
                          if (data.origin !== "update") {
                            return;
                          }

                          // Skip messages types other than pickers
                          if (data.type !== "picker") {
                            return;
                          }

                          // Skip other ids
                          if (data.content.id !== "user-type-id") {
                            return;
                          }

                          // check fingerprint
                         if (msgFingerprint && (msgFingerprint === data.fingerprint)) {
                             return;
                         }
                         else {
                            msgFingerprint = data.fingerprint;
                        }

                          let _choice = data.content.choices.find(choice => choice.selected)

                            if(_choice.value == "yes"){
                                $dollar.push(["do", "message:show", ["text", "If you joined less than 24h ago, checkout your confirmation email: it contains a link to create your account. \n\n Else, if you forgot your password, you can just click [reset password](https://remotive.com/web/reset_password?) and enter the email address used for payment. \n\n If your question is about something else, please type it below and I’ll get back to you as soon as possible. Many thanks!"]]);
                            }
                            else {
                                $dollar.push(["do", "message:show", ["text", "If you are not a paying user, you don’t have an account or password in place. \n\n Please visit [Remotive Accelerator](https://remotive.com/accelerator) to learn more. \n\n If your question is about something else, please type it below and I’ll get back to you as soon as possible. Many thanks!"]]);
                            }


                        }])
    </script>
</head>

<body>
    <div id="wrapwrap" class="   ">
        <link rel="stylesheet" href="/remotive_website_layout/static/src/css/website_common_v7.css" async />
        <link rel="stylesheet" href="/remotive_website_layout/static/refactoring/css/menu.css?v=3" async />
        <link rel="stylesheet" href="/remotive_website_job/static/refactoring/css/index.min.css?v=10" async />
        <link rel="stylesheet"
            href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" />
        <nav id="navbar"
            class="tw-w-full tw-px-4 tw-mx-auto tw-fixed tw-inset-x-0 tw-top-0 tw-z-20 tw-max-w-7xl md:tw-px-6 lg:tw-px-8 remotive-bg-light"
            style>
            <div class="tw-items-center tw-justify-between md:tw-flex">
                <div class="tw-flex tw-items-center tw-justify-between tw-h-16">
                    <a class="tw-flex-shrink-0" aria-label="Homepage" href="/">
                        <img src="/remotive_website_layout/static/src/brand/SVG/wordmark_H_orange.svg" width="220" height="55" draggable="false" class="tw-w-auto tw-h-12" alt />
                    </a>
                    <div class="tw-flex tw-items-center md:tw-hidden">
                        <button id="nav-burger" aria-label="Menu" class="tw-inline-flex tw-items-center tw-justify-center tw-p-2 remotive-btn-chocolate focus:tw-outline-none">
<svg id="nav-burger-closed" class="tw-w-6 tw-h-6" stroke="currentColor" fill="none" viewBox="0 0 24 24">
<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h16"></path>
</svg>
<svg id="nav-burger-opened" class="tw-hidden tw-w-6 tw-h-6" stroke="currentColor" fill="none" viewBox="0 0 24 24">
<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"></path>
</svg>
</button>
                    </div>
                </div>
                <div class="tw-hidden tw-block" id="nav-mobile" style="height: 100vh;">
                    <div class="tw-mx-auto tw-mt-12">
                        <div>
                            <span class="h2 tw-block tw-px-1 tw-pt-1 tw-leading-5 remotive-text-default-color">
Find remote jobs
</span>
                        </div>
                        <div class="tw-font-normal tw-mt-2">
                            <div class="tw-py-1 md:tw-bg-white md:tw-rounded-md md:tw-shadow-xs" role="menu"
                                aria-orientation="vertical" aria-labelledby="user-menu">
                                <a href="/remote-jobs"
                                    class="tw-block tw-px-1 tw-py-2 tw-leading-5 remotive-text-default-color remotive-url focus:tw-outline-none">
                                    Search by skill & location
                                </a>
                                <a href="/remote-companies"
                                    class="tw-block tw-px-1 tw-py-2 tw-leading-5 remotive-text-default-color remotive-url focus:tw-outline-none">
                                    Search by company
                                </a>
                                <a href="/remote-jobs/rss-feed"
                                    class="tw-block tw-px-1 tw-py-2 tw-leading-5 remotive-text-default-color remotive-url focus:tw-outline-none">
                                    RSS Feeds
                                </a>
                                <a href="/remote-jobs/api"
                                    class="tw-block tw-px-1 tw-py-2 tw-leading-5 remotive-text-default-color remotive-url focus:tw-outline-none">
                                    Public API
                                </a>
                                <a href="/accelerator"
                                    class="tw-block tw-px-1 tw-py-2 tw-leading-5 remotive-text-default-color remotive-url focus:tw-outline-none">
                                    Join Remotive Accelerator
                                </a>
                                <a role="button" href="/accelerator"
                                    class="tw-block tw-text-center tw-mb-4 tw-mt-2 tw-px-2 tw-py-2 remotive-btn-chocolate">
                                    <span class="tw-mr-auto">Unlock 10x more jobs</span>
                                </a>
                                <a role="button" href="/web/login"
                                    class="tw-block tw-text-center tw-mb-4 tw-mt-2 tw-px-2 tw-py-2 remotive-btn-transparent">
                                    <span class="tw-mr-auto">Log in</span>
                                </a>
                            </div>
                        </div>
                    </div>
                    <div class="tw-mx-auto tw-mt-12">
                        <div>
                            <span class="h2 tw-block tw-px-1 tw-pt-1 tw-leading-5 remotive-text-default-color">
Resources
</span>
                        </div>
                        <div class="tw-font-normal tw-mt-2">
                            <div class="tw-py-1 md:tw-bg-white md:tw-rounded-md md:tw-shadow-xs" role="menu"
                                aria-orientation="vertical" aria-labelledby="user-menu">
                                <a href="/blog/tag/job-search-tips/"
                                    class="tw-block tw-px-1 tw-py-2 tw-leading-5 remotive-text-default-color remotive-url focus:tw-outline-none">
                                    Job Search Tips
                                </a>
                                <a href="/webinar"
                                    class="tw-block tw-px-1 tw-py-2 tw-leading-5 remotive-text-default-color remotive-url focus:tw-outline-none">
                                    Webinar
                                </a>
                                <a href="/blog/digital-nomad-visas/"
                                    class="tw-block tw-px-1 tw-py-2 tw-leading-5 remotive-text-default-color remotive-url focus:tw-outline-none">
                                    Digital Nomad Visas
                                </a>
                                <a href="/about"
                                    class="tw-block tw-px-1 tw-py-2 tw-leading-5 remotive-text-default-color remotive-url focus:tw-outline-none"
                                    style="white-space: nowrap;">
                                    About us
                                </a>
                            </div>
                        </div>
                    </div>
                    <div class="tw-mx-auto tw-mt-12">
                        <div class="tw-font-normal tw-mt-2">
                            <div class="tw-py-1 md:tw-bg-white md:tw-rounded-md md:tw-shadow-xs" role="menu"
                                aria-orientation="vertical" aria-labelledby="user-menu">
                                <a role="button" href="/hire"
                                    class="tw-block tw-text-center tw-mb-4 tw-mt-2 tw-px-2 tw-py-2 remotive-btn-transparent">
                                    <span class="tw-mr-auto">For Employers</span>
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="remotive-bold tw-items-center tw-hidden md:tw-flex">
                    <div class="md:tw-relative md:tw-ml-3 tw-my-2" id="nav-applicants-link">
                        <div class="tw-flex" style="align-items: center">
                            <a href="#nav-applicants-link"
                                class="remotive-dropdown-menu tw-block tw-px-1 tw-pt-1 tw-text-base tw-leading-5 remotive-text-default-color remotive-url focus:tw-outline-none">
                                Find remote jobs ⌄
                            </a>
                        </div>
                        <div class="tw-font-normal tw-right-0 tw-hidden tw-mt-2 tw-origin-top-right md:tw-absolute md:tw-rounded-md md:tw-shadow-lg"
                            id="nav-applicants-dropdown">
                            <div class="tw-py-1 md:tw-bg-white md:tw-rounded-md md:tw-shadow-xs" role="menu"
                                aria-orientation="vertical" aria-labelledby="user-menu">
                                <a href="/remote-jobs"
                                    class="tw-block tw-px-4 tw-py-2 tw-leading-5 remotive-text-default-color remotive-url focus:tw-outline-none"
                                    style="white-space: nowrap;">
                                    Search by skill & location
                                </a>
                                <a href="/remote-companies"
                                    class="tw-block tw-px-4 tw-py-2 tw-leading-5 remotive-text-default-color remotive-url focus:tw-outline-none"
                                    style="white-space: nowrap;">
                                    Search by company
                                </a>
                                <a href="/remote-jobs/rss-feed"
                                    class="tw-block tw-px-4 tw-py-2 tw-leading-5 remotive-text-default-color remotive-url focus:tw-outline-none"
                                    style="white-space: nowrap;">
                                    RSS Feeds
                                </a>
                                <a href="/remote-jobs/api"
                                    class="tw-block tw-px-4 tw-py-2 tw-leading-5 remotive-text-default-color remotive-url focus:tw-outline-none"
                                    style="white-space: nowrap;">
                                    Public API
                                </a>
                                <a href="/accelerator"
                                    class="tw-block tw-px-4 tw-py-2 tw-leading-5 remotive-text-default-color remotive-url focus:tw-outline-none"
                                    style="white-space: nowrap;">
                                    Join Remotive Accelerator
                                </a>
                                <a role="button" href="/accelerator"
                                    class="remotive-only-public tw-block tw-text-center tw-mb-4 tw-mt-2 tw-ml-4 tw-mr-4 tw-px-2 tw-py-2 remotive-btn-chocolate">
                                    <span class="tw-mr-auto">Unlock 10x more jobs</span>
                                </a>
                            </div>
                        </div>
                    </div>
                    <div class="md:tw-relative md:tw-ml-3">
                        <div class="tw-flex" style="align-items: center" id="nav-resources-link">
                            <a href="#nav-resources-link"
                                class="remotive-dropdown-menu tw-block tw-px-1 tw-pt-1 tw-text-base tw-leading-5 remotive-text-default-color remotive-url focus:tw-outline-none">
                                Resources ⌄
                            </a>
                        </div>
                        <div class="tw-font-normal tw-right-0 tw-hidden tw-w-48 tw-mt-2 tw-origin-top-right md:tw-absolute md:tw-rounded-md md:tw-shadow-lg"
                            id="nav-resources-dropdown">
                            <div class="tw-py-1 md:tw-bg-white md:tw-rounded-md md:tw-shadow-xs" role="menu"
                                aria-orientation="vertical" aria-labelledby="user-menu">
                                <a href="/blog/tag/job-search-tips/"
                                    class="tw-block tw-px-4 tw-py-2 tw-leading-5 remotive-text-default-color remotive-url focus:tw-outline-none">
                                    Job Search Tips
                                </a>
                                <a href="/webinar"
                                    class="tw-block tw-px-4 tw-py-2 tw-leading-5 remotive-text-default-color remotive-url focus:tw-outline-none">
                                    Webinar
                                </a>
                                <a href="/blog/digital-nomad-visas/"
                                    class="tw-block tw-px-4 tw-py-2 tw-leading-5 remotive-text-default-color remotive-url focus:tw-outline-none">
                                    Digital Nomad Visas
                                </a>
                                <a href="/about"
                                    class="tw-block tw-px-4 tw-py-2 tw-leading-5 remotive-text-default-color remotive-url focus:tw-outline-none"
                                    style="white-space: nowrap;">
                                    About us
                                </a>
                            </div>
                        </div>
                    </div>
                    <div class="tw-flex tw-mt-4 tw-mb-4 tw-text-center md:tw-ml-8 md:tw-my-0">
                        <a role="button" href="/my"
                            class="remotive-only-private tw-block tw-px-4 tw-py-2 remotive-btn-transparent tw-mr-2">
                            <span class="tw-mr-auto">My Account</span>
                        </a>
                        <a role="button" href="/web/login"
                            class="remotive-only-public tw-block tw-px-4 tw-py-2 remotive-btn-transparent tw-mr-2">
                            <span class="tw-mr-auto">Log in</span>
                        </a>
                        <a role="button" href="/hire" class="tw-block tw-px-4 tw-py-2 remotive-btn-transparent">
                            For Employers
                        </a>
                    </div>
                </div>
            </div>
        </nav>
        <script src="/remotive_website_layout/static/refactoring/js/menu.js?v=3"></script>
        <script async data-uid="399c937c47" src="https://remotive.ck.page/399c937c47/index.js"></script>
        <script type="application/ld+json">
            {
                "@context": "http://schema.org",
                "@type": "Organization",
                "name": "Remotive",
                "url": "https://remotive.com",
                "logo": "https://remotive.com/logo_remotive",
                "sameAs": [
                "https://twitter.com/remotiveio"
                ]
                }
        </script>
        <script type="application/ld+json">
            {
                "@context": "http://schema.org",
                "@type": "WebSite",
                "name": "Remotive",
                "url": "https://remotive.com",
                "potentialAction": {
                "@type": "SearchAction",
                "target": "https://remotive.com/?live_jobs%5Bquery%5D={search_term_string}",
                "query-input": "required name=search_term_string"
                }
                }
        </script>
        <main>
            <div class="tw-mt-8 tw-text-center">
                <h1>Remotive Accelerator Account</h1>
                <p class="tw-mt-4">Login to your account to unlock 10x more jobs!</p>
                <p class="tw-mt-4">
                    👋 Only paying users can Log In 👨‍💻 <br/>
⚠ Non-paying users have no login/password on Remotive 🙌<br/>
🎉 <a class="remotive-url tw-underline" href="https://remotive.com/accelerator">Join Remotive Accelerator</a> to get access
                    today!<br/>
                </p>
            </div>
            <div class="oe_website_login_container">
                <form class="oe_login_form" role="form" method="post"
                    onsubmit="this.action = this.action + location.hash" action="/web/login">
                    <input type="hidden" name="csrf_token" value="2a5b008b6318f8d1fc83aa96d428bdcf39c595deo1713465352" />
                    <div class="form-group field-login">
                        <label for="login">Email</label>
                        <input type="text" placeholder="Email" name="login" id="login" required="required" autofocus="autofocus" autocapitalize="off" class="form-control " />
                    </div>
                    <div class="form-group field-password">
                        <label for="password">Password</label>
                        <input type="password" placeholder="Password" name="password" id="password" required="required" autocomplete="current-password" maxlength="4096" class="form-control " />
                    </div>
                    <div class="clearfix oe_login_buttons text-center mb-1 pt-3">
                        <button type="submit" class="remotive-btn-chocolate tw-w-full">Log in</button>
                        <div class="justify-content-between mt-2 d-flex small">
                            <a href="/web/reset_password?email=malengadev%40gmail.com&amp;password=Bju49Aaz%40%21r69UG">Forgot
                                your password? Reset it here.</a>
                        </div>
                        <div class="o_login_auth"></div>
                    </div>
                    <input type="hidden" name="redirect" />
                </form>
            </div>
            <div class="tw-mt-8 tw-text-center">
                <p class="tw-mt-4">Are you a hiring manager?</p>
                <a role="button" class="remotive-url tw-underline tw-w-auto tw-mt-4" href="/job/post/new">
                    Post a Job here
                </a>
            </div>
        </main>
        <div style="background-color: #f4e9da;">
            <div class="tw-block tw-px-4 tw-text-right md:tw-hidden">
                <button id="footer-burger" aria-label="Footer" class="tw-inline-flex tw-items-center tw-justify-center tw-px-2 tw-py-2 tw-transition tw-duration-150 tw-ease-in-out tw-rounded-md hover:tw-text-white focus:tw-outline-none focus:tw-text-white">
<svg id="footer-burger-closed" class="tw-w-6 tw-h-6" stroke="currentColor" fill="none" viewBox="0 0 24 24">
<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h16"></path>
</svg>
<svg id="footer-burger-opened" class="tw-hidden tw-w-6 tw-h-6" stroke="currentColor" fill="none" viewBox="0 0 24 24">
<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"></path>
</svg>
</button>
            </div>
            <div class="tw-hidden md:tw-pt-16 tw-p-6 md:tw-items-start md:tw-justify-between md:tw-flex-wrap md:tw-flex md:tw-content-left"
                id="footer-mobile">
                <div class="tw-mb-4">
                    <a href="/" class="tw-block tw-mb-2 remotive-bold tw-leading-5 tw-uppercase">Remotive
                    </a>
                    <ul class="tw-text-sm tw-font-light" style="list-style-type:none">
                        <li>
                            <a href="https://remotive.getrewardful.com/signup" target="_blank">
                                Remotive Affiliate Program
                            </a>
                        </li>
                        <li>
                            <a href="https://support.remotive.com/en/article/ycrtby/">
                                Sponsorship
                            </a>
                        </li>
                        <li>
                            <a href="https://support.remotive.com/en/category/l3ahqd/">
                                Press
                            </a>
                        </li>
                        <li>
                            <a href="/about">
                                About
                            </a>
                        </li>
                        <li>
                            <a href="https://support.remotive.com/en/article/u4kbkf/" target="_blank">Terms of Use</a> &
                            <a href="https://support.remotive.com/en/article/1mkziff/" target="_blank">Privacy
                                Policy</a>
                        </li>
                    </ul>
                </div>
                <div class="tw-mb-4">
                    <span class="tw-block tw-mb-2 remotive-bold tw-leading-5 tw-uppercase">Find Remote Jobs
</span>
                    <ul class="tw-text-sm tw-text-light" style="list-style-type:none">
                        <li>
                            <a href="/accelerator">
                                Join Remotive Accelerator
                            </a>
                        </li>
                        <li>
                            <a href="/blog/tag/job-search-tips/">
                                Remote Job Search Tips
                            </a>
                        </li>
                        <li>
                            <a href="/salaries">
                                Developer Salaries
                            </a>
                        </li>
                        <li>
                            <a href="/remote-jobs/api">
                                Remotive Jobs Public API
                            </a>
                            &
                            <a href="/remote-jobs/rss-feed" style="display: flex;">RSS Feeds
                                <div class="rss-symbol"></div>
                            </a>
                        </li>
                    </ul>
                </div>
                <div class="tw-mb-4">
                    <span class="tw-block tw-mb-2 remotive-bold tw-leading-5 tw-uppercase">Hiring Remotely
</span>
                    <ul class="tw-text-sm tw-text-light" style="list-style-type:none">
                        <li>
                            <a href="/hire">
                                Why Remotive?
                            </a>
                        </li>
                        <li>
                            <a href="/job/post/new">
                                Post a Remote Job
                            </a>
                        </li>
                        <li>
                            <a href="/blog/tag/hiring-remotely/">
                                Remote Hiring Tips
                            </a>
                        </li>
                        <li>
                            <a href="https://support.remotive.com">
                                Help Center for Recruiters
                            </a>
                        </li>
                    </ul>
                </div>
                <div class="tw-mb-4">
                    <span class="tw-block tw-mb-2 remotive-bold tw-leading-5 tw-uppercase">Quick Access
</span>
                    <ul class="tw-text-sm tw-text-light" style="list-style-type:none">
                        <li>
                            <a href="/remote-javascript-jobs">
                                Remote Javascript Jobs
                            </a>
                        </li>
                        <li>
                            <a href="/remote-python-jobs">
                                Remote Python Jobs
                            </a>
                        </li>
                        <li>
                            <a href="/all-tags-index">
                                See More Jobs by Tags
                            </a>
                        </li>
                        <li>
                            <a href="/all-remote-companies-index">
                                All Remote Companies
                            </a>
                        </li>
                    </ul>
                </div>
            </div>
            <div id="last-el-footer" class="tw-mt-2 ">
                <div class="tw-justify-between tw-px-6 tw-mb-2 tw-text-xs tw-text-center">
                    <p>© 2014-2024, made Remotely with ❤️</p>
                </div>
                <div class="tw-p-4 tw-text-center remotive-bg">
                    <div class="tw-flex tw-items-center tw-justify-between tw-w-full tw-mx-auto sm:tw-w-1/3 tw-h-8">
                        <a target="_blank" rel="external noopener noreferrer"
                            href="https://www.linkedin.com/company/remotive.io/" aria-label="LinkedIn"
                            style="font-size: 1.5em;" class="fa fa-linkedin hover:tw-text-white">
                        </a>
                        <a target="_blank" rel="external noopener noreferrer" href="https://twitter.com/remotiveio/"
                            aria-label="Twitter" style="font-size: 1.5em;" class="fa fa-twitter hover:tw-text-white">
                        </a>
                        <a target="_blank" rel="external noopener noreferrer"
                            href="https://www.reddit.com/r/remotivejobs/" aria-label="Reddit" style="font-size: 1.5em;"
                            class="fa fa-reddit hover:tw-text-white">
                        </a>
                        <a target="_blank" rel="external noopener noreferrer" href="https://t.me/remotejobsenglish/"
                            aria-label="Telegram" style="font-size: 1.5em;" class="fa fa-telegram hover:tw-text-white">
                        </a>
                        <a target="_blank" rel="external noopener noreferrer"
                            href="https://www.facebook.com/remotivedotcom/" aria-label="Facebook"
                            style="font-size: 1.5em;" class="fa fa-facebook hover:tw-text-white">
                        </a>
                        <a target="_blank" rel="external noopener noreferrer"
                            href="https://www.instagram.com/remotiveio/" aria-label="Instagram"
                            style="font-size: 1.5em;" class="fa fa-instagram hover:tw-text-white">
                        </a>
                        <a target="_blank" rel="external noopener noreferrer" href="/accelerator"
                            aria-label="Slack Community" style="font-size: 1.5em;"
                            class="fa fa-slack hover:tw-text-white">
                        </a>
                        <a href="/cdn-cgi/l/email-protection#f8909d949497b88a9d95978c918e9dd69b9795"
                            style="font-size: 1.5em;" class="fa fa-envelope hover:tw-text-white" aria-label="Email us">
                        </a>
                    </div>
                </div>
            </div>
        </div>
        <script data-cfasync="false" src="/cdn-cgi/scripts/5c5dd728/cloudflare-static/email-decode.min.js"></script>
        <script src="/remotive_website_layout/static/refactoring/js/footer.js"></script>
        <script async defer src="https://sa.remotive.com/latest.js"></script>
        <noscript>
            <img src="https://sa.remotive.com/noscript.gif" alt="" referrerpolicy="no-referrer-when-downgrade"/>
        </noscript>
    </div>
    <script id="tracking_code">
        (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
            (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
            m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
            })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

            ga('create', _.str.trim('UA-135550517-1'), 'auto');
            ga('send','pageview');
    </script>
</body>

</html>
''';
