const puppeteer = require(‘puppeteer’)async function savePDF( file_path, html ) {    try{
        let options = {
            headless: true,
            args: [‘--disable-dev-shm-usage’,‘--no-sandbox’]
        }
        if(process.env.NODE_ENV ==‘production’){
            options.executablePath = ‘/usr/bin/chromium-browser’;
        }        const browser = await puppeteer.launch(options);
        const page = await browser.newPage();
        await page.setContent( html, { waitFor: ‘networkidle2’ } )
        const pdf = await page.pdf({ format: ‘A4’ });
        await browser.close();
        return pdf
    }catch(e){
        console.error(e);
        return false
    }
  }
