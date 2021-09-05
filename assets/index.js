const admin = require('firebase-admin');
const amazonPaapi = require('amazon-paapi');
const serviceAccount = require('./serviceAccount.json');

admin.initializeApp({
    credential: admin.credential.cert(serviceAccount)
});

const db = admin.firestore();

exports.handler = async (event, context, callback) => {

    const commonParameters = {
        PartnerType: 'Associates',
        Marketplace: 'www.amazon.in',
        PartnerTag: process.env.PartnerTag,
        AccessKey: process.env.AccessKey,
        SecretKey: process.env.SecretKey
    };

    const requestParameters = {
        Keywords: "Today's deals",
        Resources: [
            'Images.Primary.Large',
            'Images.Variants.Large',
            'ItemInfo.ByLineInfo',
            'ItemInfo.Features',
            'ItemInfo.Title',
            'Offers.Listings.Price'
        ],
        ItemCount: 10
    };

    await clearPreviousDataFromFirestore();
    await uploadDealsToFirestore(commonParameters, requestParameters);
    await uploadBabyDealsToFirestore(commonParameters, requestParameters);
    await uploadBeautyDealsToFirestore(commonParameters, requestParameters);
    await uploadBooksDealsToFirestore(commonParameters, requestParameters);
    await uploadComputersDealsToFirestore(commonParameters, requestParameters);
    await uploadFurnitureDealsToFirestore(commonParameters, requestParameters);
    await uploadMoviesAndTVDealsToFirestore(commonParameters, requestParameters);
    await uploadHomeAndKitchenDealsToFirestore(commonParameters, requestParameters);
    await uploadFashionDealsToFirestore(commonParameters, requestParameters);
    await uploadElectronicsDealsToFirestore(commonParameters, requestParameters);
    await uploadVideoGamesDealsToFirestore(commonParameters, requestParameters);
    await uploadMiscellaneousDealsToFirestore(commonParameters, requestParameters);

}

const uploadDealsToFirestore = async (commonParameters, requestParameters) => {
    let requestParametersUpdated = {...requestParameters};
    let itemsList = [];

    for (let i=1; i<=10; i++) {
        await delay(1500);

        requestParametersUpdated['ItemPage'] = i;
        await amazonPaapi.SearchItems(commonParameters, requestParametersUpdated)
            .then((data) => {
                itemsList.push(...data['SearchResult']['Items']);
            })
            .catch((error) => {
                console.log(error);
            });

        if (itemsList.length % 10 != 0) break;
    }

    await addData("deals", {Items: JSON.parse(JSON.stringify(itemsList))});
}

const uploadBabyDealsToFirestore = async (commonParameters, requestParameters) => {
    const requestParametersUpdated = {...requestParameters, SearchIndex: 'Baby'};
    let itemsList = [];

    for (let i=1; i<=10; i++) {
        await delay(1500);

        requestParametersUpdated['ItemPage'] = i;
        await amazonPaapi.SearchItems(commonParameters, requestParametersUpdated)
            .then((data) => {
                itemsList.push(...data['SearchResult']['Items']);
            })
            .catch((error) => {
                console.log(error);
            });

        if (itemsList.length % 10 != 0) break;
    }

    await addData("baby-deals", {Items: JSON.parse(JSON.stringify(itemsList))});
}

const uploadBeautyDealsToFirestore = async (commonParameters, requestParameters) => {
    const requestParametersUpdated = {...requestParameters, SearchIndex: 'Beauty'};
    let itemsList = [];

    for (let i=1; i<=10; i++) {
        await delay(1500);

        requestParametersUpdated['ItemPage'] = i;
        await amazonPaapi.SearchItems(commonParameters, requestParametersUpdated)
            .then((data) => {
                itemsList.push(...data['SearchResult']['Items']);
            })
            .catch((error) => {
                console.log(error);
            });

        if (itemsList.length % 10 != 0) break;
    }

    await addData("beauty-deals", {Items: JSON.parse(JSON.stringify(itemsList))});
}

const uploadBooksDealsToFirestore = async (commonParameters, requestParameters) => {
    const requestParametersUpdated = {...requestParameters, SearchIndex: 'Books'};
    let itemsList = [];

    for (let i=1; i<=10; i++) {
        await delay(1500);

        requestParametersUpdated['ItemPage'] = i;
        await amazonPaapi.SearchItems(commonParameters, requestParametersUpdated)
            .then((data) => {
                itemsList.push(...data['SearchResult']['Items']);
            })
            .catch((error) => {
                console.log(error);
            });

        if (itemsList.length % 10 != 0) break;
    }

    await addData("books-deals", {Items: JSON.parse(JSON.stringify(itemsList))});
}

const uploadComputersDealsToFirestore = async (commonParameters, requestParameters) => {
    const requestParametersUpdated = {...requestParameters, SearchIndex: 'Computers'};
    let itemsList = [];

    for (let i=1; i<=10; i++) {
        await delay(1500);

        requestParametersUpdated['ItemPage'] = i;
        await amazonPaapi.SearchItems(commonParameters, requestParametersUpdated)
            .then((data) => {
                itemsList.push(...data['SearchResult']['Items']);
            })
            .catch((error) => {
                console.log(error);
            });

        if (itemsList.length % 10 != 0) break;
    }

    await addData("computers-deals", {Items: JSON.parse(JSON.stringify(itemsList))});
}

const uploadFurnitureDealsToFirestore = async (commonParameters, requestParameters) => {
    const requestParametersUpdated = {...requestParameters, SearchIndex: 'Furniture'};
    let itemsList = [];

    for (let i=1; i<=10; i++) {
        await delay(1500);

        requestParametersUpdated['ItemPage'] = i;
        await amazonPaapi.SearchItems(commonParameters, requestParametersUpdated)
            .then((data) => {
                itemsList.push(...data['SearchResult']['Items']);
            })
            .catch((error) => {
                console.log(error);
            });

        if (itemsList.length % 10 != 0) break;
    }

    await addData("furniture-deals", {Items: JSON.parse(JSON.stringify(itemsList))});
}

const uploadMoviesAndTVDealsToFirestore = async (commonParameters, requestParameters) => {
    const requestParametersUpdated = {...requestParameters, SearchIndex: 'MoviesAndTV'};
    let itemsList = [];

    for (let i=1; i<=10; i++) {
        await delay(1500);

        requestParametersUpdated['ItemPage'] = i;
        await amazonPaapi.SearchItems(commonParameters, requestParametersUpdated)
            .then((data) => {
                itemsList.push(...data['SearchResult']['Items']);
            })
            .catch((error) => {
                console.log(error);
            });

        if (itemsList.length % 10 != 0) break;
    }

    await addData("moviesandtv-deals", {Items: JSON.parse(JSON.stringify(itemsList))});
}

const uploadHomeAndKitchenDealsToFirestore = async (commonParameters, requestParameters) => {
    const requestParametersUpdated = {...requestParameters, SearchIndex: 'HomeAndKitchen'};
    let itemsList = [];

    for (let i=1; i<=10; i++) {
        await delay(1500);

        requestParametersUpdated['ItemPage'] = i;
        await amazonPaapi.SearchItems(commonParameters, requestParametersUpdated)
            .then((data) => {
                itemsList.push(...data['SearchResult']['Items']);
            })
            .catch((error) => {
                console.log(error);
            });

        if (itemsList.length % 10 != 0) break;
    }

    await addData("homeandkitchen-deals", {Items: JSON.parse(JSON.stringify(itemsList))});
}

const uploadFashionDealsToFirestore = async (commonParameters, requestParameters) => {
    const requestParametersUpdated = {...requestParameters, SearchIndex: 'Fashion'};
    let itemsList = [];

    for (let i=1; i<=10; i++) {
        await delay(1500);

        requestParametersUpdated['ItemPage'] = i;
        await amazonPaapi.SearchItems(commonParameters, requestParametersUpdated)
            .then((data) => {
                itemsList.push(...data['SearchResult']['Items']);
            })
            .catch((error) => {
                console.log(error);
            });

        if (itemsList.length % 10 != 0) break;
    }

    await addData("fashion-deals", {Items: JSON.parse(JSON.stringify(itemsList))});
}

const uploadElectronicsDealsToFirestore = async (commonParameters, requestParameters) => {
    const requestParametersUpdated = {...requestParameters, SearchIndex: 'Electronics'};
    let itemsList = [];

    for (let i=1; i<=10; i++) {
        await delay(1500);

        requestParametersUpdated['ItemPage'] = i;
        await amazonPaapi.SearchItems(commonParameters, requestParametersUpdated)
            .then((data) => {
                itemsList.push(...data['SearchResult']['Items']);
            })
            .catch((error) => {
                console.log(error);
            });

        if (itemsList.length % 10 != 0) break;
    }

    await addData("electronics-deals", {Items: JSON.parse(JSON.stringify(itemsList))});
}

const uploadVideoGamesDealsToFirestore = async (commonParameters, requestParameters) => {
    const requestParametersUpdated = {...requestParameters, SearchIndex: 'VideoGames'};
    let itemsList = [];

    for (let i=1; i<=10; i++) {
        await delay(1500);

        requestParametersUpdated['ItemPage'] = i;
        await amazonPaapi.SearchItems(commonParameters, requestParametersUpdated)
            .then((data) => {
                itemsList.push(...data['SearchResult']['Items']);
            })
            .catch((error) => {
                console.log(error);
            });

        if (itemsList.length % 10 != 0) break;
    }

    await addData("videogames-deals", {Items: JSON.parse(JSON.stringify(itemsList))});
}

const uploadMiscellaneousDealsToFirestore = async (commonParameters, requestParameters) => {
    const requestParametersUpdated = {...requestParameters, SearchIndex: 'EverythingElse'};
    let itemsList = [];

    for (let i=1; i<=10; i++) {
        await delay(1500);

        requestParametersUpdated['ItemPage'] = i;
        await amazonPaapi.SearchItems(commonParameters, requestParametersUpdated)
            .then((data) => {
                itemsList.push(...data['SearchResult']['Items']);
            })
            .catch((error) => {
                console.log(error);
            });

        if (itemsList.length % 10 != 0) break;
    }

    await addData("miscellaneous-deals", {Items: JSON.parse(JSON.stringify(itemsList))});
}

const addData = async (collectionPath, data) => {
    await db.collection(collectionPath).add(data).then((ref) => {
        console.log("Data added successfully");
    }).catch((error) => {
        console.log(error);
    });
}

const delay = (delayInMs) => {
    return new Promise(res => setTimeout(res, delayInMs));
}

const clearPreviousDataFromFirestore = async () => {
    await db.collection('deals').listDocuments().then(mapVal => {
        mapVal.map((val) => {
            val.delete().then(() => console.log("Cleared up deals"));
        });
    });

    await db.collection('baby-deals').listDocuments().then(mapVal => {
        mapVal.map((val) => {
            val.delete().then(() => console.log("Cleared up baby-deals"));
        });
    });

    await db.collection('beauty-deals').listDocuments().then(mapVal => {
        mapVal.map((val) => {
            val.delete().then(() => console.log("Cleared up beauty-deals"));
        });
    });

    await db.collection('books-deals').listDocuments().then(mapVal => {
        mapVal.map((val) => {
            val.delete().then(() => console.log("Cleared up books-deals"));
        });
    });

    await db.collection('computers-deals').listDocuments().then(mapVal => {
        mapVal.map((val) => {
            val.delete().then(() => console.log("Cleared up computers-deals"));
        });
    });

    await db.collection('furniture-deals').listDocuments().then(mapVal => {
        mapVal.map((val) => {
            val.delete().then(() => console.log("Cleared up furniture-deals"));
        });
    });

    await db.collection('moviesandtv-deals').listDocuments().then(mapVal => {
        mapVal.map((val) => {
            val.delete().then(() => console.log("Cleared up moviesandtv-deals"));
        });
    });

    await db.collection('homeandkitchen-deals').listDocuments().then(mapVal => {
        mapVal.map((val) => {
            val.delete().then(() => console.log("Cleared up homeandkitchen-deals"));
        });
    });

    await db.collection('fashion-deals').listDocuments().then(mapVal => {
        mapVal.map((val) => {
            val.delete().then(() => console.log("Cleared up fashion-deals"));
        });
    });

    await db.collection('electronics-deals').listDocuments().then(mapVal => {
        mapVal.map((val) => {
            val.delete().then(() => console.log("Cleared up electronics-deals"));
        });
    });

    await db.collection('videogames-deals').listDocuments().then(mapVal => {
        mapVal.map((val) => {
            val.delete().then(() => console.log("Cleared up videogames-deals"));
        });
    });

    await db.collection('miscellaneous-deals').listDocuments().then(mapVal => {
        mapVal.map((val) => {
            val.delete().then(() => console.log("Cleared up miscellaneous-deals"));
        });
    });
}


// const amazonPaapi = require('amazon-paapi');
//
// const commonParameters = {
//     AccessKey: '<YOUR  ACCESS  KEY>',
//     SecretKey: '<YOUR  SECRET  KEY>',
//     PartnerTag: '<YOUR  PARTNER  TAG>', // yourtag-20
//     PartnerType: 'Associates', // Default value is Associates.
//     Marketplace: 'www.amazon.com', // Default value is US. Note: Host and Region are predetermined based on the marketplace value. There is no need for you to add Host and Region as soon as you specify the correct Marketplace value. If your region is not US or .com, please make sure you add the correct Marketplace value.
// };
//
// const requestParameters = {
//     ASIN: 'B07H65KP63',
//     Resources: [
//         'ItemInfo.Title',
//         'Offers.Listings.Price',
//         'VariationSummary.VariationDimension',
//     ],
// };
//
// /** Promise */
// amazonPaapi
//     .GetVariations(commonParameters, requestParameters)
//     .then((data) => {
//         // do something with the success response.
//         console.log(data);
//     })
//     .catch((error) => {
//         // catch an error.
//         console.log(error);
//     });

// const data = {
//     message: "Hello, world!",
//     timestamp: new Date()
// };
//
// db.collection('lambda-docs').add(data).then((ref) => {
//     // On a successful write, return an object
//     // containing the new doc id.
//     callback(null, {
//         id: ref.id
//     });
// }).catch((err) => {
//     // Forward errors if the write fails
//     callback(err);
// });
