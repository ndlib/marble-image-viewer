import queryString from 'query-string'

export const buildConfig = (id, location, themeColor = '#blue') => {
  const qs = queryString.parse(location.search)
  const hideWindowTitle = qs.title === 'false'
  const sideBarOpenByDefault = qs.sidebar === 'true'
  const thumbnailNavigationPosition = qs.thumbnails === 'true' ? 'far-bottom' : 'off'
  const fullscreen = qs.fullscreen !== 'false'
  const canvasIndex = parseInt(qs.cv, 10) || 0
  const viewerView = qs.view || 'default'
  const itemId = qs.manifest

  return {
    id: id,
    themes: {
      light: {
        palette: {
          type: 'light',
          primary: {
            main: themeColor,
          },
        },
      },
    },
    companionWindows:
      {
        position: 'right',
      },
    window: {
      allowClose: false,
      allowFullscreen: fullscreen,
      allowMaximize: false,
      hideWindowTitle: hideWindowTitle,
      sideBarOpenByDefault: sideBarOpenByDefault,
      defaultSideBarPanel: 'canvas',
      views: [
        { key: 'single' },
        { key: 'book' },
        { key: 'gallery' },
      ],
    },
    responseHeaders: {
      'Content-Type': 'text/json',
    },
    windows: [
      {
        manifestId: itemId,
        canvasIndex: canvasIndex,
        maximized: false,
        thumbnailNavigationPosition: thumbnailNavigationPosition,
        view: viewerView,
        imageToolsEnabled: true,
        imageToolsOpen: true,
      },
    ],
    workspace: {
      showZoomControls: true,
      type: 'single',
    },
    workspaceControlPanel: {
      enabled: false,
    },
  }

}
