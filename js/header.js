const initHeader = () => {
    try {
        const header = document.getElementsByClassName('cads-header')[0];
        const controlButton = document.getElementsByClassName(
            'cads-search-reveal'
        )[0];

        controlButton.addEventListener('click', () => {
            if (header.classList.contains('cads-header-show-search')) {
                header.classList.remove('cads-header-show-search');
            } else {
                header.classList.add('cads-header-show-search');
            }
        });
    } catch (e) {
        console.log(`Could not initialise header ${e}`);
    }
};

export default initHeader;