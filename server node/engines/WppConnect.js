
import wppconnect from '@wppconnect-team/wppconnect';
import Sessions from '../controllers/sessions.js';
import events from '../controllers/events.js';
import webhooks from '../controllers/webhooks.js';
import { doc, db, getDoc } from '../firebase/db.js';
import config from '../config.js';

export default class Wppconnect {

    static async start(req, res, session) {
        let token = await this.getToken(session);
        try {
            const client = await wppconnect.create({
                session: session,
                tokenStore: 'memory',
                catchQR: (base64Qrimg, ascii) => {
                    webhooks.wh_qrcode(session, base64Qrimg)
                    this.exportQR(req, res, base64Qrimg, session);
                    Sessions.addInfoSession(session, {
                        qrCode: base64Qrimg
                    })
                },
                statusFind: (statusSession, session) => {
                    console.log(statusSession)
                    Sessions.addInfoSession(session, {
                        status: statusSession
                    })
                    if (statusSession != 'qrReadSuccess') {
                        webhooks.wh_connect(session, statusSession)
                    }
                    if (statusSession === 'browserClose' ||
                        statusSession === 'qrReadFail' ||
                        statusSession === 'autocloseCalled' ||
                        statusSession === 'serverClose') {
                        req.io.emit('whatsapp-status', false)
                    }
                    if (statusSession === 'isLogged' ||
                        statusSession === 'qrReadSuccess' ||
                        statusSession === 'chatsAvailable' ||
                        statusSession === 'inChat') {
                        req.io.emit('whatsapp-status', true)
                    }

                },
                headless: true,
                logQR: true,
                browserWS: '', //browserless !=  '' ? browserless.replace('https://', 'wss://')+'?token='+token_browser : '',
                useChrome: true,
                updatesLog: false,
                autoClose: 90000,
                browserArgs: [
                    // '--log-level=3',
                    // '--no-default-browser-check',
                    // '--disable-site-isolation-trials',
                    // '--no-experiments',
                    // '--ignore-gpu-blacklist',
                    // '--ignore-certificate-errors',
                    // '--ignore-certificate-errors-spki-list',
                    // '--disable-gpu',
                    // '--disable-extensions',
                    // '--disable-default-apps',
                    // '--enable-features=NetworkService',
                    // '--disable-setuid-sandbox',
                    // '--no-sandbox',
                    // // Extras
                    // '--disable-webgl',
                    // '--disable-threaded-animation',
                    // '--disable-threaded-scrolling',
                    // '--disable-in-process-stack-traces',
                    // '--disable-histogram-customizer',
                    // '--disable-gl-extensions',
                    // '--disable-composited-antialiasing',
                    // '--disable-canvas-aa',
                    // '--disable-3d-apis',
                    // '--disable-accelerated-2d-canvas',
                    // '--disable-accelerated-jpeg-decoding',
                    // '--disable-accelerated-mjpeg-decode',
                    // '--disable-app-list-dismiss-on-blur',
                    // '--disable-accelerated-video-decode',
                    '--log-level=3',
                    '--no-default-browser-check',
                    '--disable-site-isolation-trials',
                    '--no-experiments',
                    '--ignore-gpu-blacklist',
                    '--ignore-certificate-errors',
                    '--ignore-certificate-errors-spki-list',
                    '--disable-gpu',
                    '--disable-extensions',
                    '--disable-default-apps',
                    '--enable-features=NetworkService',
                    '--disable-setuid-sandbox',
                    '--no-sandbox',
                    // Extras
                    '--cpu-throttling-rate=5',
                    '--disable-dev-shm-usage',
                    '--no-first-run',
                    '--disable-webgl',
                    '--no-zygote',
                    '--single-process',
                    '--disable-threaded-animation',
                    '--disable-threaded-scrolling',
                    '--disable-in-process-stack-traces',
                    '--disable-histogram-customizer',
                    '--disable-gl-extensions',
                    '--disable-composited-antialiasing',
                    '--disable-canvas-aa',
                    '--disable-3d-apis',
                    '--disable-accelerated-2d-canvas',
                    '--disable-accelerated-jpeg-decoding',
                    '--disable-accelerated-mjpeg-decode',
                    '--disable-app-list-dismiss-on-blur',
                    '--disable-accelerated-video-decode',
                    '--disable-background-networking',
                    '--disable-background-timer-throttling',
                    '--disable-backgrounding-occluded-windows',
                    '--disable-breakpad',
                    '--disable-client-side-phishing-detection',
                    '--disable-component-update',
                    '--disable-datasaver-prompt',
                    '--disable-desktop-notifications',
                    '--disable-domain-reliability',
                    '--disable-features=TranslateUI',
                    '--disable-geolocation',
                    '--disable-infobars',
                    '--disable-notifications',
                    '--disable-popup-blocking',
                    '--disable-print-preview',
                    '--disable-prompt-on-repost',
                    '--disable-renderer-backgrounding',
                    '--disable-search-geolocation-disclosure',
                    '--disable-session-crashed-bubble',
                    '--disable-speech-api',
                    '--disable-sync',
                    '--disable-tab-for-desktop-share',
                    '--disable-translate',
                    '--disable-web-security', // desativa a política de mesma origem do navegador
                    '--disable-background-fetch', // desativa o recurso de busca em segundo plano
                    '--disable-background-video-track', // desativa a reprodução de vídeo em segundo plano
                    '--disable-notifications-api', // desativa a API de notificações do navegador
                    '--disable-offer-store-unmasked-wallet-cards', // desativa a oferta de armazenamento de cartões de carteira sem máscara
                    '--disable-remote-playback-api', // desativa a API de reprodução remota
                    '--disable-rtc-smoothness-algorithm', // desativa o algoritmo de suavização RTC
                    '--disable-smooth-scrolling', // desativa a rolagem suave do navegador
                    '--disable-software-rasterizer', // desativa o renderizador de software
                    '--disable-webauthn', // desativa a autenticação da Web
                    '--force-color-profile=srgb', // força o perfil de cores sRGB
                    '--force-fieldtrials=*BackgroundStartupTesting/Group1/', // força o uso de experimentos de inicialização em segundo plano
                    '--renderer-process-limit=1', // limita o número de processos de renderização a 1
                    '--safebrowsing-disable-auto-update', // desativa a atualização automática do serviço de navegação segura do Google
                    '--top-chrome-md=',
                    '--use-gl=swiftshader', // usa o renderizador SwiftShader para emular o OpenGL
                    '--disable-webgl-image-chromium', // desativa a imagem WebGL
                    '--enable-low-res-tiling', // ativa o desempenho em telhas de baixa resolução
                    '--enable-zero-copy', // ativa a cópia de zero
                    '--disable-es3-gl-context', // desativa o contexto WebGL ES3
                    '--disable-es3-apis', // desativa a API WebGL ES3
                    '--enable-features=PageLifecycleInterest', // ativa o interesse do ciclo de vida da página
                    '--enable-features=TabHoverCards', // ativa cartões suspensos da guia
                    '--enable-features=TextFragmentAnchor', // ativa âncoras de fragmentos de texto
                    '--enable-features=HeavyAdPrivacyMitigations', // ativa as mitigação de privacidade para anúncios pesados
                    '--enable-features=ScrollAnchorSerialization', // ativa a serialização de âncora de rolagem
                    '--enable-features=PasswordImport', // ativa a importação de senha
                    '--enable-features=PreciseMemoryInfo', // ativa informações de memória precisa
                    '--enable-features=V8VmFuture', // ativa o futuro da VM do V8
                    '--enable-features=WebUplink', // ativa o uplink da web
                    '--enable-features=WinrtGeolocationImplementation', // ativa a implementação de geolocalização do WinRT
                    '--enable-features=WinrtSensorImplementation', // ativa a implementação do sensor do WinRT
                    '--enable-features=WinrtSensorPlatform', // ativa a plataforma de sensores do WinRT
                    '--disable-logging', // desativa o registro
                    '--disable-background-worker-throttling', // desativa a limitação do trabalhador de fundo
                    '--enable-blink-features=IdleDetection', // ativa a detecção de inatividade
                    '--enable-blink-features=LayoutNG', // ativa o novo motor de layout NG
                    '--enable-blink-features=PreciseMemoryInfo', // ativa informações de memória precisa no Blink
                    '--enable-blink-features=ScrollAnchorSerialization', // ativa a serialização de âncora de rolagem no Blink
                    '--enable-blink-features=V8VmFuture', // ativa o futuro da VM do V8 no Blink
                    '--disable-pnacl-crash-throttling', // desativa a limitação de falhas PNaCl
                    '--disable-voice-input', // desativa a entrada de voz
                    '--enable-fast-unload', // ativa a descarga rápida
                    '--enable-parallel-downloading', // ativa o download paralelo
                    '--enable-simple-cache-backend', // ativa o backend de cache simples
                    '--enable-tcp-fast-open', // ativa o TCP Fast Open
                    '--enable-threaded-compositing', // ativa a composição roscada
                    '--force-color-profile=srgb', // força o perfil de cores sRGB
                    '--safebrowsing-disable-auto-update', // desativa a atualização automática do serviço de navegação segura do Google
                    '--top-chrome-md=',
                    '--use-gl=swiftshader' // usa o renderizador SwiftShader para emular o OpenGL
                ],
                puppeteerOptions: { userDataDir: './tokens/' + session, },
                createPathFileToken: false,
                sessionToken: {
                    WABrowserId: token.WABrowserId,
                    WASecretBundle: token.WASecretBundle,
                    WAToken1: token.WAToken1,
                    WAToken2: token.WAToken2
                }

            })

            wppconnect.defaultLogger.level = 'silly';
            let info = await client.getWid()
            let tokens = await client.getSessionTokenBrowser()
            let browser = []
            // browserless != '' ? browserless+'/devtools/inspector.html?token='+token_browser+'&wss='+browserless.replace('https://', '')+':443/devtools/page/'+client.page._target._targetInfo.targetId : null
            webhooks.wh_connect(session, 'connected', info, browser, tokens)
            events.receiveMessage(session, client)
            events.statusMessage(session, client)
            if (config.useHere === 'true') {
                events.statusConnection(session, client)
            }
            Sessions.addInfoSession(session, {
                client: client,
                tokens: tokens
            })
            return client, tokens;
        } catch (error) {
            console.log(error)
        }

    }

    static async stop(session) {
        let data = Sessions.getSession(session)
        let response = await data.client.close()
        if (response) {
            return true
        }
        return false
    }
    static async exportQR(req, res, qrCode, session) {
        qrCode = qrCode.replace('data:image/png;base64,', '');
        const imageBuffer = Buffer.from(qrCode, 'base64');
        req.io.emit('qrCode',
            {
                data: 'data:image/png;base64,' + imageBuffer.toString('base64'),
                session: session
            }
        );
    }

    static async getToken(session) {
        return new Promise(async (resolve, reject) => {
            try {
                const Session = doc(db, "Sessions", session);
                const dados = await getDoc(Session);
                if (dados.exists() && dados.data()?.Engine === process.env.ENGINE) {
                    let data = {
                        'WABrowserId': dados.data().WABrowserId,
                        'WASecretBundle': dados.data().WASecretBundle,
                        'WAToken1': dados.data().WAToken1,
                        'WAToken2': dados.data().WAToken2,
                        'Engine': process.env.ENGINE
                    }
                    resolve(data)
                } else {
                    resolve('no results found')
                }

            } catch (error) {
                reject(error)
            }
        })
    }
}
