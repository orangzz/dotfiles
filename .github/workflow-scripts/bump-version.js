//  bump-version:
//     runs-on: ubuntu-latest
//     steps:
//       - uses: actions/checkout
//       - uses: actions/setup-node
//         with:
//           node-version: '22'
//       - name: Setup Git
//         run: |
//           git config.user.name ${{  github.actor }}
//           git config.user.email ${{ github.actor }}@users.noreply.github.com
//       - name: Bump version
//         run: npm version ${{ github.event.inputs.version }}
//       - name: Push latest version
//         run: git push --tags origin main
