Map<String, String> countryLanguageMap = {
 "AF": "fa",  // Afghanistan
    "AL": "sq",  // Albania
    "DZ": "ar",  // Algeria
    "AO": "pt",  // Angola
    "AQ": "no",  // Antarctica
    "AG": "en",  // Antigua and Barbuda
    "AR": "es",  // Argentina
    "AM": "hy",  // Armenia
    "AW": "nl",  // Aruba
    "AU": "en",  // Australia
    "AT": "de",  // Austria
    "AZ": "az",  // Azerbaijan
    "BS": "en",  // Bahamas
    "BH": "ar",  // Bahrain
    "BD": "bn",  // Bangladesh
    "BE": "nl",  // Belgium
    "BJ": "fr",  // Benin
    "BM": "en",  // Bermuda
    "BT": "dz",  // Bhutan
    "BO": "es",  // Bolivia
    "BQ": "nl",  // Bonaire, Sint Eustatius and Saba
    "BA": "bs",  // Bosnia and Herzegovina
    "BW": "en",  // Botswana
    "BV": "no",  // Bouvet Island
    "BR": "pt",  // Brazil
    "IO": "en",  // British Indian Ocean Territory
    "BN": "ms",  // Brunei
    "BG": "bg",  // Bulgaria
    "BF": "fr",  // Burkina Faso
    "BY": "be",  // Belarus
    "BZ": "en",  // Belize
    "CA": "en",  // Canada
    "CV": "pt",  // Cape Verde
    "KY": "en",  // Cayman Islands
    "KZ": "ru",  // Kazakhstan
    "TD": "fr",  // Chad
    "CL": "es",  // Chile
    "CN": "zh",  // China
    "CX": "en",  // Christmas Island
    "CC": "en",  // Cocos (Keeling) Islands
    "CO": "es",  // Colombia
    "KM": "fr",  // Comoros
    "CG": "fr",  // Congo, Democratic Republic of the
    "CD": "fr",  // Congo, Republic of the
    "CK": "en",  // Cook Islands
    "CR": "es",  // Costa Rica
    "CU": "es",  // Cuba
    "CW": "nl",  // Curaçao
    "CY": "el",  // Cyprus
    "CZ": "cs",  // Czech Republic
    "DK": "da",  // Denmark
    "DJ": "fr",  // Djibouti
    "DM": "en",  // Dominica
    "DO": "es",  // Dominican Republic
    "EC": "es",  // Ecuador
    "EG": "ar",  // Egypt
    "SV": "es",  // El Salvador
    "GQ": "fr",  // Equatorial Guinea
    "ER": "ti",  // Eritrea
    "EE": "et",  // Estonia
    "ET": "am",  // Ethiopia
    "FK": "en",  // Falkland Islands (Malvinas)
    "FO": "fo",  // Faroe Islands
    "FJ": "en",  // Fiji
    "FI": "fi",  // Finland
    "FR": "fr",  // France
    "PF": "fr",  // French Polynesia
    "GA": "fr",  // Gabon
    "GM": "en",  // Gambia
    "GE": "ka",  // Georgia
    "DE": "de",  // Germany
    "GH": "en",  // Ghana
    "GI": "en",  // Gibraltar
    "GR": "el",  // Greece
    "GL": "kl",  // Greenland
    "GD": "en",  // Grenada
    "GP": "fr",  // Guadeloupe
    "GU": "en",  // Guam
    "GT": "es",  // Guatemala
    "GN": "fr",  // Guinea
    "GW": "pt",  // Guinea-Bissau
    "GY": "en",  // Guyana
    "HT": "fr",  // Haiti
    "HM": "en",  // Heard Island

};

String convertCountryCodeToLanguage(String countryCode) {
  // Default to English if the country code is not found
  return countryLanguageMap[countryCode.toLowerCase()] ?? 'en';
}
