type Config = {
  websiteSiteName: string;
};

export default {
  websiteSiteName: process.env.WEBSITE_SITE_NAME || '',
} as Config;
