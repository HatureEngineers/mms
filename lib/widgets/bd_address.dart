// বাংলাদেশের বিভাগ, জেলা ও থানা/উপজেলা ডাটা
final List<String> divisions = [
  "ঢাকা",
  "চট্টগ্রাম",
  "রাজশাহী",
  "খুলনা",
  "বরিশাল",
  "সিলেট",
  "রংপুর",
  "ময়মনসিংহ",
];

final Map<String, Map<String, List<String>>> districts = {
  "ঢাকা": {
    "নরসিংদী": ["বেলাবো", "মনোহরদী", "নরসিংদী", "পলাশ", "রায়পুরা", "শিবপুর"],
    "গাজীপুর": ["কালীগঞ্জ", "কালিয়াকৈর", "কাপাসিয়া", "গাজীপুর সদর", "শ্রীপুর"],
    "শরীয়তপুর": ["শরিয়তপুর সদর", "নড়িয়া", "জাজিরা", "গোসাইরহাট", "ভেদরগঞ্জ", "ডামুড্যা"],
    "নারায়ণগঞ্জ": ["আড়াইহাজার", "বন্দর", "নারায়ণগঞ্জ সদর", "রূপগঞ্জ", "সোনারগাঁ"],
    "টাঙ্গাইল": [
      "বাসাইল", "ভুয়াপুর", "দেলদুয়ার", "ঘাটাইল", "গোপালপুর", "মধুপুর",
      "মির্জাপুর", "নাগরপুর", "সখিপুর", "টাঙ্গাইল সদর", "কালিহাতী", "ধনবাড়ী"
    ],
    "কিশোরগঞ্জ": [
      "ইটনা", "কটিয়াদী", "ভৈরব", "তাড়াইল", "হোসেনপুর", "পাকুন্দিয়া",
      "কুলিয়ারচর", "কিশোরগঞ্জ সদর", "করিমগঞ্জ", "বাজিতপুর", "অষ্টগ্রাম",
      "মিঠামইন", "নিকলী"
    ],
    "মানিকগঞ্জ": ["হরিরামপুর", "সাটুরিয়া", "মানিকগঞ্জ সদর", "ঘিওর", "শিবালয়", "দৌলতপুর", "সিংগাইর"],
    "ঢাকা": ["সাভার", "ধামরাই", "কেরাণীগঞ্জ", "নবাবগঞ্জ", "দোহার"],
    "মুন্সিগঞ্জ": ["মুন্সিগঞ্জ সদর", "শ্রীনগর", "সিরাজদিখান", "লৌহজং", "গজারিয়া", "টংগীবাড়ি"],
    "রাজবাড়ী": ["রাজবাড়ী সদর", "গোয়ালন্দ", "পাংশা", "বালিয়াকান্দি", "কালুখালী"],
    "মাদারীপুর": ["মাদারীপুর সদর", "শিবচর", "কালকিনি", "রাজৈর", "ডাসার"],
    "গোপালগঞ্জ": ["গোপালগঞ্জ সদর", "কাশিয়ানী", "টুংগীপাড়া", "কোটালীপাড়া", "মুকসুদপুর"],
    "ফরিদপুর": ["ফরিদপুর সদর", "আলফাডাঙ্গা", "বোয়ালমারী", "সদরপুর", "নগরকান্দা", "ভাঙ্গা", "চরভদ্রাসন", "মধুখালী", "সালথা"]
  },
  "চট্টগ্রাম": {
    "কুমিল্লা": [
      "দেবিদ্বার", "বরুড়া", "ব্রাহ্মণপাড়া", "চান্দিনা", "চৌদ্দগ্রাম", "দাউদকান্দি",
      "হোমনা", "লাকসাম", "মুরাদনগর", "নাঙ্গলকোট", "কুমিল্লা সদর", "মেঘনা",
      "মনোহরগঞ্জ", "সদর দক্ষিণ", "তিতাস", "বুড়িচং", "লালমাই"
    ],
    "ফেনী": ["ছাগলনাইয়া", "ফেনী সদর", "সোনাগাজী", "ফুলগাজী", "পরশুরাম", "দাগনভূঞা"],
    "ব্রাহ্মণবাড়িয়া": [
      "ব্রাহ্মণবাড়িয়া সদর", "কসবা", "নাসিরনগর", "সরাইল", "আশুগঞ্জ",
      "আখাউড়া", "নবীনগর", "বাঞ্ছারামপুর", "বিজয়নগর"
    ],
    "রাঙ্গামাটি": [
      "রাঙ্গামাটি সদর", "কাপ্তাই", "কাউখালী", "বাঘাইছড়ি", "বরকল",
      "লংগদু", "রাজস্থলী", "বিলাইছড়ি", "জুরাছড়ি", "নানিয়ারচর"
    ],
    "নোয়াখালী": [
      "নোয়াখালী", "কোম্পানীগঞ্জ", "বেগমগঞ্জ", "হাতিয়া", "সুবর্ণচর",
      "কবিরহাট", "সেনবাগ", "চাটখিল", "সোনাইমুড়ী"
    ],
    "চাঁদপুর": ["হাইমচর", "কচুয়া", "শাহরাস্তি", "চাঁদপুর সদর", "মতলব", "হাজীগঞ্জ", "ফরিদগঞ্জ"],
    "লক্ষ্মীপুর": ["লক্ষ্মীপুর সদর", "কমলনগর", "রায়পুর", "রামগতি", "রামগঞ্জ"],
    "চট্টগ্রাম": [
      "রাঙ্গুনিয়া", "সীতাকুন্ড", "মীরসরাই", "পটিয়া", "সন্দ্বীপ", "বাঁশখালী",
      "বোয়ালখালী", "আনোয়ারা", "চন্দনাইশ", "সাতকানিয়া", "লোহাগাড়া",
      "হাটহাজারী", "ফটিকছড়ি", "রাউজান", "কর্ণফুলী"
    ],
    "কক্সবাজার": ["কক্সবাজার সদর", "চকরিয়া", "কুতুবদিয়া", "উখিয়া", "মহেশখালী", "পেকুয়া", "রামু", "টেকনাফ"],
    "খাগড়াছড়ি": [
      "খাগড়াছড়ি সদর", "দিঘীনালা", "পানছড়ি", "লক্ষীছড়ি",
      "মহালছড়ি", "মানিকছড়ি", "রামগড়", "মাটিরাঙ্গা", "গুইমারা"
    ],
    "বান্দরবান": ["বান্দরবান সদর", "আলীকদম", "নাইক্ষ্যংছড়ি", "রোয়াংছড়ি", "লামা", "রুমা", "থানচি"]
  },

  "রাজশাহী": {
    "রাজশাহী": ["পবা", "চারঘাট", "বাঘা", "পুঠিয়া", "তানোর", "মোহনপুর", "দূর্গাপুর", "বাগমারা", "গোদাগাড়ী"],
    "নাটোর": ["নাটোর সদর", "লালপুর", "বাগাতিপাড়া", "বড়াইগ্রাম", "গুরুদাসপুর", "সিংড়া", "নলডাঙ্গা"],
    "নওগাঁ": [
      "নওগাঁ সদর", "আত্রাই", "রাণীনগর", "পত্নীতলা", "সাপাহার",
      "পোরশা", "মান্দা", "মহাদেবপুর", "ধামইরহাট", "বদলগাছী", "নিয়ামতপুর"
    ],
    "চাঁপাইনবাবগঞ্জ": ["চাঁপাইনবাবগঞ্জ সদর", "শিবগঞ্জ", "ভোলাহাট", "গোমস্তাপুর", "নাচোল"],
    "বগুড়া": [
      "বগুড়া সদর", "শাজাহানপুর", "শেরপুর", "ধুনট", "সারিয়াকান্দি",
      "গাবতলী", "সোনাতলা", "শিবগঞ্জ", "দুপচাচিয়া", "কাহালু", "আদমদীঘি", "নন্দীগ্রাম"
    ],
    "জয়পুরহাট": ["জয়পুরহাট সদর", "পাঁচবিবি", "আক্কেলপুর", "ক্ষেতলাল", "কালাই"],
    "পাবনা": ["পাবনা সদর", "সাঁথিয়া", "সুজানগর", "বেড়া", "ঈশ্বরদী", "ভাঙ্গুড়া", "ফরিদপুর", "চাটমোহর", "আটঘড়িয়া"],
    "সিরাজগঞ্জ": ["সিরাজগঞ্জ সদর", "রায়গঞ্জ", "কাজিপুর", "তাড়াশ", "শাহজাদপুর", "উল্লাপাড়া", "কামারখন্দ", "বেলকুচি", "চৌহালী"]
  },

  "খুলনা": {
    "খুলনা": ["কয়রা", "ডুমুরিয়া", "তেরখাদা", "দাকোপ", "দিঘলিয়া", "পাইকগাছা", "ফুলতলা", "বটিয়াঘাটা", "রূপসা"],
    "বাগেরহাট": ["কচুয়া", "চিতলমারী", "ফকিরহাট", "বাগেরহাট সদর", "মোংলা", "মোড়েলগঞ্জ", "মোল্লাহাট", "রামপাল", "শরণখোলা"],
    "সাতক্ষীরা": ["সাতক্ষীরা সদর", "তালা", "কলারোয়া", "আশাশুনি", "দেবহাটা", "শ্যামনগর", "কালীগঞ্জ"],
    "যশোর": ["যশোর সদর", "অভয়নগর", "কেশবপুর", "চৌগাছা", "ঝিকরগাছা", "বাঘারপাড়া", "মনিরামপুর", "শার্শা"],
    "নড়াইল": ["কালিয়া", "নড়াইল সদর", "লোহাগড়া"],
    "মাগুরা": ["মাগুরা সদর", "মোহাম্মদপুর", "শালিখা", "শ্রীপুর"],
    "ঝিনাইদহ": ["কালীগঞ্জ", "কোটচাঁদপুর", "ঝিনাইদহ সদর", "মহেশপুর", "শৈলকুপা", "হরিণাকুন্ডু"],
    "কুষ্টিয়া": ["কুমারখালী", "কুষ্টিয়া সদর", "খোকসা", "দৌলতপুর", "ভেড়ামারা", "মিরপুর"],
    "চুয়াডাঙ্গা": ["আলমডাঙ্গা", "চুয়াডাঙ্গা সদর", "জীবননগর", "দামুড়হুদা"],
    "মেহেরপুর": ["গাংনী", "মেহেরপুর সদর", "মুজিবনগর"]
  },
  "বরিশাল": {
    "বরিশাল": [
      "আগৈলঝারা", "বাকেরগঞ্জ", "বাবুগঞ্জ", "বানারিপাড়া",
      "গৌরনদী", "হিজলা", "বরিশাল সদর", "মেহেন্দিগঞ্জ", "মুলাদি", "উজিরপুর"
    ],
    "পটুয়াখালী": ["পটুয়াখালী সদর", "বাউফল", "দশমিনা", "গলাচিপা", "কলাপাড়া", "মির্জাগঞ্জ", "দুমকি", "রাঙ্গাবালী"],
    "ভোলা": ["ভোলা সদর", "তজমুদ্দিন", "দৌলতখান", "বোরহানউদ্দিন", "মনপুরা", "লালমোহন", "চরফ্যাশন"],
    "পিরোজপুর": ["কাউখালী", "নাজিরপুর", "নেছারাবাদ (স্বরূপকাঠি)", "পিরোজপুর সদর", "ভাণ্ডারিয়া", "মঠবাড়িয়া", "ইন্দুরকানী"],
    "বরগুনা": ["বরগুনা সদর", "আমতলী", "পাথরঘাটা", "বেতাগি", "বামনা", "তালতলী"],
    "ঝালকাঠি": ["কাঁঠালিয়া", "ঝালকাঠি সদর", "নলছিটি", "রাজাপুর"]
  },
  "সিলেট": {
    "সিলেট": [
      "সিলেট সদর", "বালাগঞ্জ", "বিয়ানীবাজার", "বিশ্বনাথ", "কোম্পানীগঞ্জ",
      "ফেঞ্চুগঞ্জ", "গোলাপগঞ্জ", "গোয়াইনঘাট", "জৈন্তাপুর", "জকিগঞ্জ",
      "কানাইঘাট", "দক্ষিণ সুরমা", "ওসমানীনগর"
    ],
    "সুনামগঞ্জ": [
      "সুনামগঞ্জ সদর", "বিশ্বম্ভরপুর", "ছাতক", "দিরাই",
      "ধর্মপাশা", "দোয়ারাবাজার", "জগন্নাথপুর", "জামালগঞ্জ",
      "তাহিরপুর", "শাল্লা", "শান্তিগঞ্জ", "মধ্যনগর"
    ],
    "হবিগঞ্জ": ["হবিগঞ্জ সদর", "আজমিরীগঞ্জ", "বাহুবল", "বানিয়াচং", "চুনারুঘাট", "লাখাই", "মাধবপুর", "নবীগঞ্জ", "শায়েস্তাগঞ্জ"],
    "মৌলভীবাজার": ["মৌলভীবাজার সদর", "বড়লেখা", "কুলাউড়া", "কমলগঞ্জ", "রাজনগর", "শ্রীমঙ্গল", "জুড়ী"],
  },
  "রংপুর": {
    "রংপুর": [
      "রংপুর সদর", "মিঠাপুকুর", "তারাগঞ্জ", "বদরগঞ্জ",
      "পীরগঞ্জ", "পীরগাছা", "গংগাচড়া", "কাউনিয়া"
    ],
    "পঞ্চগড়": ["পঞ্চগড় সদর", "তেতুলিয়া", "আটোয়ারী", "দেবীগঞ্জ", "বোদা"],
    "ঠাকুরগাঁও": ["ঠাকুরগাঁও সদর", "রানীশংকৈল", "বালয়িাডাঙ্গী", "হরিপুর", "পীরগঞ্জ"],
    "নীলফামারী": ["নীলফামারী সদর", "ডিমলা", "জলঢাকা", "সৈয়দপুর", "কিশোরগঞ্জ", "ডোমার"],
    "লালমনিরহাট": ["লালমনিরহাট সদর", "পাটগ্রাম", "হাতীবান্ধা", "আদিতমারী", "কালীগঞ্জ"],
    "গাইবান্ধা": ["গাইবান্ধা সদর", "গোবিন্দগঞ্জ", "সাঘাটা", "পলাশবাড়ী", "সাদুল্যাপুর", "সুন্দরগঞ্জ", "ফুলছড়ি"],
    "কুড়িগ্রাম": [
      "কুড়িগ্রাম সদর", "উলিপুর", "ফুলবাড়ী", "ভুরুঙ্গামারী",
      "নাগেশ্বরী", "রাজারহাট", "রাজিবপুর", "রৌমারী", "চিলমারী"
    ],
    "দিনাজপুর": [
      "দিনাজপুর সদর", "কাহারোল", "খানসামা", "বীরগঞ্জ",
      "চিরিরবন্দর", "বিরামপুর", "ঘোড়াঘাট", "নবাবগঞ্জ", "বোচাগঞ্জ",
      "ফুলবাড়ী", "বিরল", "পার্বতীপুর", "হাকিমপুর"
    ],
  },
  "ময়মনসিংহ": {
    "ময়মনসিংহ": [
      "ময়মনসিংহ সদর", "ত্রিশাল", "ভালুকা", "ফুলবাড়িয়া",
      "মুক্তাগাছা", "গফরগাঁও", "গৌরীপুর", "ঈশ্বরগঞ্জ", "নান্দাইল",
      "তারাকান্দা", "ফুলপুর", "হালুয়াঘাট", "ধোবাউড়া"
    ],
    "জামালপুর": [
      "জামালপুর সদর", "ইসলামপুর", "দেওয়ানগঞ্জ", "মাদারগঞ্জ", "মেলান্দহ", "সরিষাবাড়ী", "বকশীগঞ্জ"
    ],
    "নেত্রকোনা": [
      "নেত্রকোণাসদর", "পূর্বধলা", "দুর্গাপুর", "বারহাট্টা",
      "আটপাড়া", "মদন", "কেন্দুয়া", "মোহনগঞ্জ", "কলমাকান্দা", "খালিয়াজুরী"
    ],
    "শেরপুর": ["শেরপুর সদর", "নকলা", "ঝিনাইগাতী", "নালিতাবাড়ী", "শ্রীবরদী"],
  },
};
