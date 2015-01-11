window.app.directive('inputFocus', function todoFocus($timeout) {
        return function (scope, elem, attrs) {
            scope.$watch(attrs.inputFocus, function (newVal) {
                if (newVal) {
                    $timeout(function () {
                        elem[0].focus();
                    }, 0, false);
                }
            });
        };
    });